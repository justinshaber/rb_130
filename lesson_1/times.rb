# 5.times do |num|
#   puts num
# end

# first block argument is 0
# last block argument is 1 less than the calling integer object
# returns calling integer object

def times(int)
  counter = 0

  while counter < int
    yield(counter)
    counter += 1
  end

  int
end

times(5) do |num|
  puts num
end

=begin
Trace the code executing above
  1. Line 20 - the `times` method is invoked, explicitly passing an integer argument `5` and implicitly passing a block.
  2. Line  9 - local variable `int` references the passed integer `5`.
  3. Line 10 - local `counter` variable initialized to `0`
  4. Line 12 - conditional
  5. Line 13 - yield invokes the passed block passing in the integer referenced by local variable `counter` as an argument
  6. Line 20 - local variable num is initialized to reference passed integer referenced by counter
  7. Line 21 - outputs integer referenced by num (counter) to the console
  8. Line 14 - variable reassignment
  9. Repeat steps 4 - 8 until the conditional evaluates as false.
  10.Line 18 - end of method definition is reached, last evaluated expression is implicitly returned - integer passed in as arg.
=end