# O(n) time, 0(n) memory
def reverse_map(array)
  array.each_with_index.map { |el, idx| array[- idx - 1] }
end

# O(n) time, 0(n) memory
def reverse_assign(array)
  Array.new(array.size)
  
  array.size.times do |idx|
    result[- idx - 1] = array[idx] 
  end
  result
end

# O(n²) time, 0(n) memory
def reverse_push(array)
  result = []

  (array.size - 1).downto(0) do |idx|
    result << array[idx]
  end
  result
end

# O(n²) time, 0(n) memory
def reverse_unshift(array)
  result = []

  array.each do |el|
    result.unshift(el)
  end
  result
end

binding.irb
