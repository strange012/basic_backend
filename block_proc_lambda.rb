
## block
10.times { |x| puts x }
10.times do |x|
  puts x
end

## proc
a = proc { |x| puts x}

10.times(&a)

## lambda
a = lambda { |x| puts x }
a = ->(x) { puts x }

10.times(&a)
