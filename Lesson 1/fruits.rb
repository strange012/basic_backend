class Fruit
  class InvalidColorError < StandardError; end
  class InvalidNameError < StandardError; end

  NAMES = [:apple, :orange, :pear]
  COLORS = [:red, :green, :orange, :yellow]
  SWEET_COLORS = [:red, :yellow]
  SOUR_COLORS = [:orange, :green]

  def initialize(name, color, weight)
    @name = name
    @color = color
    @weight = weight

    raise InvalidNameError unless valid_name?
    raise InvalidColorError unless valid_color?
  end

  attr_accessor :name, :color, :weight

  def is_sweet?
    SWEET_COLORS.include?(color)
  end

  def is_sour?
    SOUR_COLORS.include?(color)
  end

  private

  def valid_name?
    NAMES.include?(name)
  end

  def valid_color?
    COLORS.include?(color)
  end
end

class Apple < Fruit
  COLORS = [:red, :green] ## РАЗОБРАТЬСЯ

  def initialize(color, weight)
    super(:apple, color, weight)
  end
end

class Orange < Fruit
  COLORS = [:orange, :green]

  def initialize(color, weight)
    super(:orange, color, weight)
  end
end

