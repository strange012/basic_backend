time = Time.now
a = Thread.new do
  sleep(2)
  puts "A finished after #{Time.now - time}"
end

b = Thread.new do
  sleep(1)
  puts "B finished after #{Time.now - time}"
end

a.join
b.join
puts "All threads finished after #{Time.now - time}"