def bubble_sort(array)
  # Duplicate array to avoid mutation
  sorted  = array.dup

  # Endless loop
  loop do
    # Escape criteria
    swapped = false
    # Push elements one-by-one to the top  
    (sorted.size - 1).times do |i|
      # If left element is grater than right swap them
      if sorted[i] > sorted[i + 1] 
        sorted[i], sorted[i + 1] = sorted[i + 1], sorted[i]
        # Not ready to escape, need one more run
        swapped = true
      end
    end
    # Escape if not swaps were made
    break unless swapped
  end
  sorted
end

a = [5, 4, 3, 1, 2]
p bubble_sort(a)                  # [1, 2, 3, 4 ,5]
p a                               # [5, 4, 3, 1, 2]
