[1, 2, 3].reduce(10) do |acc, num|
  acc + num
end

# => 16

array = [1, 2, 3, 4, 5]

def reduce(arr, acc = nil)
  if acc.nil?
    acc = arr[0].to_s.to_i == arr[0] ? 0 : arr[0].class.new
  end

  counter = 0

  while counter < arr.size
    acc = yield(acc, arr[counter])
    counter += 1
  end

  acc
end

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
# reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass
p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']