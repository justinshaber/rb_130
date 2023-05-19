final_arr = []
str_arr = ["Hi", "Hello", "Aloha"]

# str_arr.each { |str| arr << str + "!" }

def each(arr)
  counter = 0

  while counter < arr.size
    yield(arr[counter])
    counter += 1
  end

  arr
end

# p final_arr
# p each(str_arr) { |str| final_arr << str + "!" }
# p str_arr
# p final_arr

p final_arr
p each(str_arr) { |str| puts str }
p str_arr
p final_arr

