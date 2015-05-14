opal_filter "Array" do
  fails "Array#clone copies singleton methods"

  fails "Array#<=> calls <=> left to right and return first non-0 result"
  fails "Array#<=> returns -1 if the arrays have same length and a pair of corresponding elements returns -1 for <=>"
  fails "Array#<=> returns +1 if the arrays have same length and a pair of corresponding elements returns +1 for <=>"
  fails "Array#<=> tries to convert the passed argument to an Array using #to_ary"
  fails "Array#<=> returns nil when the argument is not array-like"

  fails "Array.[] can unpack 2 or more nested referenced array"

  fails "Array#[]= sets elements in the range arguments when passed ranges"

  fails "Array#initialize with (size, object=nil) sets the array to the values returned by the block before break is executed"
  fails "Array#initialize with (size, object=nil) returns the value passed to break"
  fails "Array#initialize with (size, object=nil) uses the block value instead of using the default value"
  fails "Array#initialize with (size, object=nil) yields the index of the element and sets the element to the value of the block"
  fails "Array#initialize with (size, object=nil) raises a TypeError if the size argument is not an Integer type"
  fails "Array#initialize with (size, object=nil) calls #to_int to convert the size argument to an Integer when object is not given"
  fails "Array#initialize with (size, object=nil) calls #to_int to convert the size argument to an Integer when object is given"
  fails "Array#initialize with (size, object=nil) raises an ArgumentError if size is too large"
  fails "Array#initialize with (size, object=nil) sets the array to size and fills with the object"
  fails "Array#initialize with (array) calls #to_ary to convert the value to an array"
  fails "Array#initialize preserves the object's identity even when changing its value"

  fails "Array#& determines equivalence between elements in the sense of eql?"

  fails "Array#- removes an identical item even when its #eql? isn't reflexive"
  fails "Array#- doesn't remove an item with the same hash but not #eql?"
  fails "Array#- removes an item identified as equivalent via #hash and #eql?"

  fails "Array#* raises a TypeError is the passed argument is nil"
  fails "Array#* converts the passed argument to a String rather than an Integer"
  fails "Array#* raises a TypeError if the argument can neither be converted to a string nor an integer"
  fails "Array#* tires to convert the passed argument to an Integer using #to_int"
  fails "Array#* tries to convert the passed argument to a String using #to_str"
  fails "Array#* with a string uses the same separator with nested arrays"
  fails "Array#* with a string returns a string formed by concatenating each element.to_str separated by separator"

  fails "Array.new with (size, object=nil) raises an ArgumentError if size is too large"
  fails "Array.new with (array) calls #to_ary to convert the value to an array"
  fails "Array.new with (size, object=nil) calls #to_int to convert the size argument to an Integer when object is given"
  fails "Array.new with (size, object=nil) calls #to_int to convert the size argument to an Integer when object is not given"
  fails "Array.new with (size, object=nil) raises a TypeError if the size argument is not an Integer type"

  fails "Array#permutation generates from a defensive copy, ignoring mutations"
  fails "Array#permutation returns an Enumerator which works as expected even when the array was modified"
  fails "Array#permutation truncates Float arguments"
  fails "Array#permutation handles nested Arrays correctly"
  fails "Array#permutation handles duplicate elements correctly"
  fails "Array#permutation returns no permutations when the given length has no permutations"
  fails "Array#permutation returns the empty permutation([]) when called on an empty Array"
  fails "Array#permutation returns the empty permutation ([[]]) when the given length is 0"
  fails "Array#permutation yields all permutations of given length to the block then returns self when called with block and argument"
  fails "Array#permutation yields all permutations to the block then returns self when called with block but no arguments"
  fails "Array#permutation returns an Enumerator of permutations of given length when called with an argument but no block"
  fails "Array#permutation returns an Enumerator of all permutations when called without a block or arguments"

  fails "Array#rassoc does not check the last element in each contained but speficically the second"
  fails "Array#rassoc calls elem == obj on the second element of each contained array"

  fails "Array#repeated_combination generates from a defensive copy, ignoring mutations"
  fails "Array#repeated_combination accepts sizes larger than the original array"
  fails "Array#repeated_combination yields a partition consisting of only singletons"
  fails "Array#repeated_combination yields nothing when the array is empty and num is non zero"
  fails "Array#repeated_combination yields [] when length is 0"
  fails "Array#repeated_combination yields the expected repeated_combinations"
  fails "Array#repeated_combination yields nothing for negative length and return self"
  fails "Array#repeated_combination returns self when a block is given"
  fails "Array#repeated_combination returns an enumerator when no block is provided"

  fails "Array#repeated_permutation generates from a defensive copy, ignoring mutations"
  fails "Array#repeated_permutation allows permutations larger than the number of elements"
  fails "Array#repeated_permutation returns an Enumerator which works as expected even when the array was modified"
  fails "Array#repeated_permutation truncates Float arguments"
  fails "Array#repeated_permutation handles duplicate elements correctly"
  fails "Array#repeated_permutation does not yield when called on an empty Array with a nonzero argument"
  fails "Array#repeated_permutation yields the empty repeated_permutation ([[]]) when the given length is 0"
  fails "Array#repeated_permutation yields all repeated_permutations to the block then returns self when called with block but no arguments"
  fails "Array#repeated_permutation returns an Enumerator of all repeated permutations of given length when called without a block"

  fails "Array#rindex rechecks the array size during iteration"

  fails "Array#rotate! with an argument n raises a TypeError if not passed an integer-like argument"
  fails "Array#rotate! with an argument n coerces the argument using to_int"
  fails "Array#rotate! with an argument n moves the first (n % size) elements at the end and returns self"
  fails "Array#rotate! when passed no argument moves the first element to the end and returns self"
  fails "Array#rotate! raises a RuntimeError on a frozen array"
  fails "Array#rotate! does nothing and returns self when the length is zero or one"
  fails "Array#rotate with an argument n raises a TypeError if not passed an integer-like argument"
  fails "Array#rotate with an argument n coerces the argument using to_int"
  fails "Array#rotate with an argument n returns a copy of the array with the first (n % size) elements moved at the end"
  fails "Array#rotate when passed no argument returns a copy of the array with the first element moved at the end"
  fails "Array#rotate does not return subclass instance for Array subclasses"
  fails "Array#rotate does not return self"
  fails "Array#rotate does not mutate the receiver"
  fails "Array#rotate returns a copy of the array when its length is one or zero"

  fails "Array#sample calls #rand on the Object passed by the :random key in the arguments Hash"
  fails "Array#sample calls #to_hash to convert the passed Object"
  fails "Array#sample calls #to_int on the Object returned by #rand"
  fails "Array#sample calls #to_int on the first argument and #to_hash on the second when passed Objects"
  fails "Array#sample calls #to_int to convert the count when passed an Object"
  fails "Array#sample does not return the same value if the Array has unique values"
  fails "Array#sample ignores an Object passed for the RNG if it does not define #rand"
  fails "Array#sample raises ArgumentError when passed a negative count"
  fails "Array#sample raises a RangeError if the value is equal to the Array size"
  fails "Array#sample raises a RangeError if the value is less than zero"
  fails "Array#sample returns at most the number of elements in the Array"
  fails "Array#sample when the object returned by #rand is not a Fixnum but responds to #to_int calls #to_int on the Object"
  fails "Array#sample when the object returned by #rand is not a Fixnum but responds to #to_int raises a RangeError if the value is equal to the Array size"
  fails "Array#sample when the object returned by #rand is not a Fixnum but responds to #to_int raises a RangeError if the value is less than zero"
  fails "Array#sample with options calls #rand on the Object passed by the :random key in the arguments Hash"
  fails "Array#sample with options calls #to_hash to convert the passed Object"
  fails "Array#sample with options calls #to_int on the first argument and #to_hash on the second when passed Objects"
  fails "Array#sample with options ignores an Object passed for the RNG if it does not define #rand"
  fails "Array#sample with options when the object returned by #rand is a Fixnum raises a RangeError if the value is equal to the Array size"
  fails "Array#sample with options when the object returned by #rand is a Fixnum raises a RangeError if the value is less than zero"
  fails "Array#sample with options when the object returned by #rand is a Fixnum uses the fixnum as index"

  fails "Array#select returns a new array of elements for which block is true"

  fails "Array#shuffle attempts coercion via #to_hash"
  fails "Array#shuffle is not destructive"
  fails "Array#shuffle returns the same values, in a usually different order"
  fails "Array#shuffle calls #rand on the Object passed by the :random key in the arguments Hash"
  fails "Array#shuffle ignores an Object passed for the RNG if it does not define #rand"
  fails "Array#shuffle accepts a Float for the value returned by #rand"
  fails "Array#shuffle calls #to_int on the Object returned by #rand"
  fails "Array#shuffle raises a RangeError if the value is less than zero"
  fails "Array#shuffle raises a RangeError if the value is equal to one"

  fails "Array#shuffle! returns the same values, in a usually different order"

  fails "Array#slice! calls to_int on range arguments"
  fails "Array#slice! calls to_int on start and length arguments"
  fails "Array#slice! does not expand array with indices out of bounds"
  fails "Array#slice! does not expand array with negative indices out of bounds"
  fails "Array#slice! removes and return elements in range"
  fails "Array#slice! removes and returns elements in end-exclusive ranges"

  fails "Array#sort_by! makes some modification even if finished sorting when it would break in the given block"
  fails "Array#sort_by! returns the specified value when it would break in the given block"
  fails "Array#sort_by! raises a RuntimeError on an empty frozen array"
  fails "Array#sort_by! raises a RuntimeError on a frozen array"
  fails "Array#sort_by! completes when supplied a block that always returns the same result"
  fails "Array#sort_by! returns an Enumerator if not given a block"
  fails "Array#sort_by! sorts array in place by passing each element to the given block"

  fails "Array#uniq compares elements based on the value returned from the block"
  fails "Array#uniq compares elements with matching hash codes with #eql?"
  fails "Array#uniq handles nil and false like any other values"
  fails "Array#uniq uses eql? semantics"
  fails "Array#uniq yields items in order"

  fails "Array#uniq! compares elements based on the value returned from the block"

  fails "Array#values_at returns an array of elements at the indexes when passed indexes"
  fails "Array#values_at calls to_int on its indices"
  fails "Array#values_at returns an array of elements in the ranges when passes ranges"
  fails "Array#values_at calls to_int on arguments of ranges when passes ranges"
  fails "Array#values_at does not return subclass instance on Array subclasses"
  fails "Array#values_at when passed ranges returns an array of elements in the ranges"
  fails "Array#values_at when passed ranges calls to_int on arguments of ranges"
  fails "Array#values_at when passed a range fills with nil if the index is out of the range"
  fails "Array#values_at when passed a range on an empty array fills with nils if the index is out of the range"


  fails "Array#zip calls #to_ary to convert the argument to an Array"
  fails "Array#zip uses #each to extract arguments' elements when #to_ary fails"

  fails "Array#hash returns the same fixnum for arrays with the same content"

  fails "Array#partition returns in the left array values for which the block evaluates to true"

  fails "Array#| acts as if using an intermediate hash to collect values"

  # recursive arrays
  fails "Array#uniq! properly handles recursive arrays"
  fails "Array#<=> properly handles recursive arrays"
  fails "Array#values_at properly handles recursive arrays"
  fails "Array#hash returns the same hash for equal recursive arrays through hashes"
end
