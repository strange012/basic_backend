class Kabanchik

  class InvalidNameError < StandardError; end # No need to create 3 types of error
  class InvalidAgeError < StandardError; end
  class InvalidStatusError < StandardError; end

  AGE = (14..103) # Redundant braces

  attr_accessor :name, :age, :na_podskoke

  def initialize(name, age, na_podskoke)
      @name = name
      @age = age
      @na_podskoke = na_podskoke

      raise InvalidNameError unless valid_name? # Move to a separate validation method
      raise InvalidAgeError unless valid_age? # raise InvalidArgument, "invalid age argument"
      raise InvalidStatusError unless valid_na_podskoke?
  end

  def obkashlyat # Naming
      if na_podskoke
          return "Уже решаю вопросик" # Redundant return
      else
          return "Поставил дело на карандаш" # Redundant return
      end
  end

  private

  def valid_name?
      return false unless (3..64).include?(name.length)
    
      name.match?(/\A[a-zA-Z]+\z/) # Regex can contain string length
  end
    
  def valid_age?
      AGE.include?(age) # self.class::AGE
  end

  def valid_na_podskoke?  
      [true, false].include?(@na_podskoke) # Should validate type, not values
  end
end

class Reshala < Kabanchik

  AGE = (35..65)

  def initialize(name, age, na_podskoke)
      super(name, age, na_podskoke)
      raise InvalidAgeError unless AGE.include?(age)
  end
end
