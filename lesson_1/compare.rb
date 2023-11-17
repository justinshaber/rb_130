def compare(str)
  puts "Before: #{str}"
  after = yield(str)
  puts "After: #{after}"
end

# compare('hi') { |word| word.upcase }

# Output:
# Before: hi
# After: HI

def time_it
  time_before = Time.now
  yield
  time_after= Time.now

  puts "It took #{time_after - time_before} seconds."
end

time_it { puts "hello world" }
