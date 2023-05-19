# array = [1, 2, 3, 4, 5]

# p array.select { |num| num.odd? }       # => [1, 3, 5]
# p array.select { |num| puts num }       # => [], because "puts num" returns nil and evaluates to false
# p array.select { |num| num + 1 }        # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true

=begin
Write a select method that mirrors the behavior of Array#select. Note that the Array#select method takes a block, then yields each element to the block. If the block evaluates to true, the current element will be included in the returned array. If the block evaluates to false, the current element will not be included in the returned array.
=end

array = [1, 2, 3, 4, 5]

def select(arr)
  arr_of_truth = []
  counter = 0

  while counter < arr.size
    if yield(arr[counter])
      arr_of_truth << arr[counter]
    end

    counter += 1
  end

  arr_of_truth
end

p select(array) { |num| num.odd? }      # => [1, 3, 5]
p select(array) { |num| puts num }      # => [], because "puts num" returns nil and evaluates to false
p select(array) { |num| num + 1 }       # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true