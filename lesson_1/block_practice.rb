# method implementation
def method_a(&block_a)
  p block_a.call(1,2,3)    # passing 1 block argument at block invocation time
end

# method invocation
method_a do |num1, num2| # expecting 2 parameters in block implementation
  puts "#{num1} #{num2}"
end