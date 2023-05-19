# Example 1: passing in a block to the `Integer#times` method.

# 3.times do |num|
#   puts num
# end
# => 3

# Example 2: passing in a block to the `Array#map` method.

[1, 2, 3].map do |num|
  num + 1
end
# => [2, 3, 4]

# Example 3: passing in a block to the `Hash#select` method.

return_val = { a: 1, b: 2, c: 3, d: 4, e: 5 }.select do |_, value|
  2
end

p return_val
# => { c: 3, d: 4, e: 5 }