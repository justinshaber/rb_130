# array = [1, 2, 3, 4, 5]

# p array.select { |num| num.odd? }       # => [1, 3, 5]
# p array.select { |num| puts num }       # => [], because "puts num" returns nil and evaluates to false
# p array.select { |num| num + 1 }        # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true

=begin
Write a map method that mirrors the behavior of Array#map. Note that the Array#map method takes a block, then yields each element to the block. The return value of the block is then stored in a new array. Array#map returns a new array.
=end

array = ["hello", "hi", "aloha", "bonjour"]

def map(arr)
  new_arr = []
  counter = 0

  while counter < arr.size
    new_arr << yield(arr[counter])
    counter += 1
  end

  new_arr
end

def map!(arr)
  counter = 0

  while counter < arr.size
    arr[counter] = yield(arr[counter])
    counter += 1
  end

  arr
end

p map(array) { |str| str.size.odd? }   # => [true, false, true, true]
p map(array) { |str| puts str }        # => [nil, nil, nil, nil], because "puts str" returns nil
p map(array) { |str| str + "!!!" }     # => ["hello!!!", "hi!!!", "aloha!!!", "bonjour!!!"], because "num + 1" evaluates to true
p array # => ["hello", "hi", "aloha", "bonjour"]

p map!(array) { |str| str.size.odd? }   # => [true, false, true, true]
p map!(array) { |str| puts str }        # => [nil, nil, nil, nil], because "puts str" returns nil
p map!(array) { |str| str + "!!!" }     # => ["hello!!!", "hi!!!", "aloha!!!", "bonjour!!!"], because "num + 1" evaluates to true
p array # => ["hello", "hi", "aloha", "bonjour"]