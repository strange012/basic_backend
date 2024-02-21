class Child < Parent # Child relates to unknown class
  # I don't think this is a correct relation
  def say_fathers_last_name # What does it mean?
    puts @last_name
  end

  private

  def valid_age?
    (0..18).include?(age) # Better to move all numbers to constants
  end
end