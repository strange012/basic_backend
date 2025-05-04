def fib(n)
  # Initial values for n=0 and n=1
  return 1 if n < 2

  # Each value is a sum of previous two
  fib(n - 1) + fib(n - 2)
end

p fib(0) # 1
p fib(1) # 1
p fib(2) # 2
p fib(3) # 3
p fib(4) # 5
p fib(5) # 8
p fib(6) # 13
p fib(7) # 21
