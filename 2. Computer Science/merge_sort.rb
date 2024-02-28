def merge_sort(array)
  # Escape if length is 1 or less
  return array if array.length <= 1 
      
  # Find the middle
  mid = array.length / 2
  # Take the first half and sort it recursive
  left = merge_sort(array[...mid])
  # Take the second half and sort it recursive
  right = merge_sort(array[mid..])
  # Merge sorted halves
  merge(left, right)
end

def merge(left, right)
  # Predefine array for memory optimization
  sorted = Array.new(left.size + right.size)

  # Set indices to zero
  idx, lidx, ridx = 0, 0, 0 
  # Go until our sorted array is full
  while idx < sorted.size
    # Escape if one of the arrays ended, fill sorted with the rest 
    if left[lidx].nil?
      sorted[idx..] = right[ridx..]
      break
    end
    # Escape if one of the arrays ended, fill sorted with the rest 
    if right[ridx].nil?
      sorted[idx..] = left[lidx..]
      break
    end
    # Insert the smallest value to sorted array
    if left[lidx] < right[ridx] 
      sorted[idx] = left[lidx]
      lidx += 1
    else
      sorted[idx] = right[ridx]
      ridx += 1
    end
    # Increase index each interation
    idx += 1
  end 
  return sorted
end

a = [2, 5, 6, 15, 20, 8, 20, 12, 13, 9, 2, 18, 1, 14, 19, 16, 7]
p merge_sort(a)      # [1, 2, 2, 5, 6, 7, 8, 9, 12, 13, 14, 15, 16, 18, 19, 20, 20]
p a                  # [2, 5, 6, 15, 20, 8, 20, 12, 13, 9, 2, 18, 1, 14, 19, 16, 7]
