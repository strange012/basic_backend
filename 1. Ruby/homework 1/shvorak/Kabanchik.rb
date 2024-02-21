class Kabanchik
  class InvalidArgumentError < StandardError; end # No need to create 3 types of error

  AGE = (14..103) # Redundant braces

  attr_reader :age
  attr_accessor :name, :na_podskoke

  def initialize(name, age, na_podskoke)
    @name = name
    @age = age
    @na_podskoke = na_podskoke

    validate!
  end

  def obkashlyat # Naming
      if na_podskoke
          return "Уже решаю вопросик" # Redundant return
      else
          return "Поставил дело на карандаш" # Redundant return
      end
  end

  def validate!
    raise InvalidArgumentError, 'invalid name' unless valid_name? # Move to a separate validation method
    raise InvalidArgumentError, 'invalid age' unless valid_age? # raise InvalidArgument, "invalid age argument"
    raise InvalidArgumentError, 'invalid AAAAA' unless valid_na_podskoke?
  end

  def valid?
    validate!

    true
  rescue InvalidArgumentError => e
    false
  end

  def age=(new_age)
    @age = new_age

    validate!
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

binding.irb