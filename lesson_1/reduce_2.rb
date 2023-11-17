array = [1, 2, 3, 4, 5]

def reduce(arr, default = 0)
  if arr[0].is_a? Integer
    acc = default
  else
    acc = arr[0].class.new
  end

  arr.each { |num| acc = yield(acc, num) }
  acc
end

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
# p reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass

p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']