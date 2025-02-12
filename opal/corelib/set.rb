# helpers: freeze
# backtick_javascript: true

# Portions Copyright (c) 2002-2013 Akinori MUSHA <knu@iDaemons.org>
class ::Set
  include ::Enumerable

  def self.[](*ary)
    new(ary)
  end

  def initialize(enum = nil, &block)
    @hash = {}

    return if enum.nil?
    ::Kernel.raise ::ArgumentError, 'value must be enumerable' unless ::Enumerable === enum

    if block
      enum.each { |item| add yield(item) }
    else
      merge(enum)
    end
  end

  def dup
    result = self.class.new
    result.merge(self)
  end

  def -(enum)
    unless enum.respond_to? :each
      ::Kernel.raise ::ArgumentError, 'value must be enumerable'
    end

    dup.subtract(enum)
  end

  def inspect
    "#<Set: {#{to_a.join(',')}}>"
  end

  def ==(other)
    if equal?(other)
      true
    elsif other.instance_of?(self.class)
      @hash == other.instance_variable_get(:@hash)
    elsif other.is_a?(::Set) && size == other.size
      other.all? { |o| @hash.include?(o) }
    else
      false
    end
  end

  def add(o)
    @hash[o] = true
    self
  end

  def classify(&block)
    return enum_for(:classify) unless block_given?

    result = ::Hash.new { |h, k| h[k] = self.class.new }

    each { |item| result[yield(item)].add item }

    result
  end

  def collect!(&block)
    return enum_for(:collect!) unless block_given?
    result = self.class.new
    each { |item| result << yield(item) }
    replace result
  end

  def compare_by_identity
    if @hash.respond_to?(:compare_by_identity)
      @hash.compare_by_identity
      self
    else
      raise NotImplementedError, "#{self.class.name}\##{__method__} is not implemented"
    end
  end

  def compare_by_identity?
    @hash.respond_to?(:compare_by_identity?) && @hash.compare_by_identity?
  end

  def delete(o)
    @hash.delete(o)
    self
  end

  def delete?(o)
    if include?(o)
      delete(o)
      self
    end
  end

  def delete_if
    return enum_for(:delete_if) unless block_given?
    # @hash.delete_if should be faster, but using it breaks the order
    # of enumeration in subclasses.
    select { |o| yield o }.each { |o| @hash.delete(o) }
    self
  end

  def freeze
    return self if frozen?

    @hash.freeze
    `$freeze(self)`
  end

  def keep_if
    return enum_for(:keep_if) unless block_given?
    reject { |o| yield o }.each { |o| @hash.delete(o) }
    self
  end

  def reject!(&block)
    return enum_for(:reject!) unless block_given?
    before = size
    delete_if(&block)
    size == before ? nil : self
  end

  def select!(&block)
    return enum_for(:select!) unless block_given?
    before = size
    keep_if(&block)
    size == before ? nil : self
  end

  def add?(o)
    if include?(o)
      nil
    else
      add(o)
    end
  end

  def each(&block)
    return enum_for(:each) unless block_given?
    @hash.each_key(&block)
    self
  end

  def empty?
    @hash.empty?
  end

  def eql?(other)
    @hash.eql?(other.instance_eval { @hash })
  end

  def clear
    @hash.clear
    self
  end

  def include?(o)
    @hash.include?(o)
  end

  def merge(enum)
    enum.each { |item| add item }
    self
  end

  def replace(enum)
    clear
    merge(enum)

    self
  end

  def size
    @hash.size
  end

  def subtract(enum)
    enum.each { |item| delete item }
    self
  end

  def |(enum)
    unless enum.respond_to? :each
      ::Kernel.raise ::ArgumentError, 'value must be enumerable'
    end
    dup.merge(enum)
  end

  %x{
    function is_set(set) {
      #{`set`.is_a?(::Set) || ::Kernel.raise(::ArgumentError, 'value must be a set')}
    }
  }

  def superset?(set)
    `is_set(set)`
    return false if size < set.size
    set.all? { |o| include?(o) }
  end

  def proper_superset?(set)
    `is_set(set)`
    return false if size <= set.size
    set.all? { |o| include?(o) }
  end

  def subset?(set)
    `is_set(set)`
    return false if set.size < size
    all? { |o| set.include?(o) }
  end

  def proper_subset?(set)
    `is_set(set)`
    return false if set.size <= size
    all? { |o| set.include?(o) }
  end

  def intersect?(set)
    `is_set(set)`
    if size < set.size
      any? { |o| set.include?(o) }
    else
      set.any? { |o| include?(o) }
    end
  end

  def disjoint?(set)
    !intersect?(set)
  end

  def to_a
    @hash.keys
  end

  alias + |
  alias < proper_subset?
  alias << add
  alias <= subset?
  alias > proper_superset?
  alias >= superset?
  alias difference -
  alias filter! select!
  alias length size
  alias map! collect!
  alias member? include?
  alias union |
end
