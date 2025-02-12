# frozen_string_literal: true

require 'opal/compiler'
require 'opal/erb'

module Opal
  module BuilderProcessors
    class Processor
      def initialize(source, filename, abs_path = nil, options = {})
        options = abs_path if abs_path.is_a? Hash

        source += "\n" unless source.end_with?("\n")
        @source, @filename, @abs_path, @options = source, filename, abs_path, options.dup
        @cache = @options.delete(:cache) { Opal.cache }
        @requires = []
        @required_trees = []
        @autoloads = []
      end
      attr_reader :source, :filename, :options, :requires, :required_trees, :autoloads, :abs_path

      def to_s
        source.to_s
      end

      class << self
        attr_reader :extensions

        def handles(*extensions)
          @extensions = extensions
          matches = extensions.join('|')
          matches = "(#{matches})" unless extensions.size == 1
          @match_regexp = Regexp.new "\\.#{matches}#{REGEXP_END}"

          ::Opal::Builder.register_processor(self, extensions)
          nil
        end

        def match?(other)
          other.is_a?(String) && other.match(match_regexp)
        end

        def match_regexp
          @match_regexp || raise(NotImplementedError)
        end
      end

      def mark_as_required(filename)
        "Opal.loaded([#{filename.to_s.inspect}]);"
      end
    end

    class JsProcessor < Processor
      handles :js

      ManualFragment = Struct.new(:line, :column, :code, :source_map_name)

      def source_map
        @source_map ||= begin
          manual_fragments = source.each_line.with_index.map do |line_source, index|
            column = line_source.index(/\S/)
            line = index + 1
            ManualFragment.new(line, column, line_source, nil)
          end

          ::Opal::SourceMap::File.new(manual_fragments, filename, source)
        end
      end

      def source
        @source.to_s + mark_as_required(@filename)
      end
    end

    class RubyProcessor < Processor
      handles :rb, :opal

      def source
        compiled.result
      end

      def source_map
        compiled.source_map
      end

      def compiled
        @compiled ||= Opal::Cache.fetch(@cache, cache_key) do
          compiler = compiler_for(@source, file: @filename)
          compiler.compile
          compiler
        end
      end

      def cache_key
        [self.class, @filename, @source, @options]
      end

      def compiler_for(source, options = {})
        ::Opal::Compiler.new(source, @options.merge(options))
      end

      def requires
        compiled.requires
      end

      def required_trees
        compiled.required_trees
      end

      def autoloads
        compiled.autoloads
      end

      # Also catch a files with missing extensions and nil.
      def self.match?(other)
        super || File.extname(other.to_s) == ''
      end
    end

    # This handler is for files named ".opalerb", which ought to
    # first get compiled to Ruby code using ERB, then with Opal.
    # Unlike below processors, OpalERBProcessor can be used to
    # compile templates, which will in turn output HTML. Take
    # a look at docs/templates.md to understand this subsystem
    # better.
    class OpalERBProcessor < RubyProcessor
      handles :opalerb

      def initialize(*args)
        super
        @source = prepare(@source, @filename)
      end

      def requires
        ['erb'] + super
      end

      private

      def prepare(source, path)
        ::Opal::ERB::Compiler.new(source, path).prepared_source
      end
    end

    # This handler is for files named ".rb.erb", which ought to
    # first get preprocessed via ERB, then via Opal.
    class RubyERBProcessor < RubyProcessor
      handles :"rb.erb"

      def compiled
        @compiled ||= begin
          erb = ::ERB.new(@source.to_s)
          erb.filename = @abs_path

          @source = erb.result

          compiler = compiler_for(@source, file: @filename)
          compiler.compile
          compiler
        end
      end
    end

    # This handler is for files named ".js.erb", which ought to
    # first get preprocessed via ERB, then served verbatim as JS.
    class ERBProcessor < Processor
      handles :erb

      def source
        erb = ::ERB.new(@source.to_s)
        erb.filename = @abs_path

        result = erb.result
        module_name = ::Opal::Compiler.module_name(@filename)
        "Opal.modules[#{module_name.inspect}] = function() {#{result}};"
      end
    end
  end
end
