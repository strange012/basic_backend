class Array
  def linear_search(val)
    each_with_index do |el, idx| 
      return idx if val == el
    end
  end

  def binary_search(val, idx = 0)
    # If size is 1 we either found our value or it doesn't exist
    return (val == first ? idx : nil) if size == 1

    middle = size / 2
    # If middle value is less than our value 
    # then we search in the second half
    if val < self[middle]
      self[...middle].binary_search(val, idx)
    # If middle value is greater than or equal our value 
    # then we search in the first half
    else
      self[middle..].binary_search(val, idx + middle)
    end
  end
end


puts [1, 2, 3, 4, 5, 6].linear_search(3) # 2
  

puts [1, 2, 3, 4, 5, 6 ,7, 8].binary_search(4) # 3
puts [1, 2, 3, 4, 5, 6 ,7, 8].binary_search(13) # nil

binding.irb