module CountAreaHelper
    def sort(obj)
      Sorter.new(obj)
    end
  
    class AreaCounter
      def initialize(obj)
        @obj = obj
      end
  
      def count_area
        if @obj.is_a?(Array) && @obj.size == 2
          return @obj[0] * @obj[1]
        elsif @obj.is_a?(Numeric)
          return @obj**2 * Math::PI
        else
          'Undefined object'
        end
      end
    end
  
    class Sorter
      def initialize(obj)
        @obj = obj
      end
  
      def transform_object_to_area_type
        areas = @obj.map { |figure| AreaCounter.new(figure).count_area }
        @obj.zip(areas)
      end
  
      def merge_sort
        transformed_array = transform_object_to_area_type
        return @obj if @obj.length <= 1
  
        mid = @obj.length / 2
        left = Sorter.new(@obj[0...mid]).merge_sort
        right = Sorter.new(@obj[mid..]).merge_sort
  
        merge(left, right)
      end
  
      def merge(left, right)
        sorted = []
        lidx, ridx = 0, 0
  
        while lidx < left.size && ridx < right.size
          left_area = left[lidx].is_a?(Array) ? left[lidx][1] : left[lidx]
          right_area = right[ridx].is_a?(Array) ? right[ridx][1] : right[ridx]
  
          if left_area < right_area
            sorted << left[lidx]
            lidx += 1
          else
            sorted << right[ridx]
            ridx += 1
          end
        end
  
        sorted.concat(left[lidx..]) if lidx < left.size
        sorted.concat(right[ridx..]) if ridx < right.size
  
        sorted
      end
    end
  end
  
  def sort_by_area(array)
    include CountAreaHelper
    sort(array).merge_sort
  end
  
  seq = [[[2, 5], 6]]
  p sort_by_area(seq)
  


 

class Shapes
  include Enumerable
  
  def initialize(array_of_shapes)
    @shapes = array_of_shapes.map { |el| self.class.build_shape(el) }
  end

  def sort_by_area
    @shapes.sort_by { |el| el.area }
  end

  def sort_by_area!
    @shapes = sort_by_area
    self
  end

  def to_output
    @shapes.map { |el| el.output }
  end

  def each(&block)
    @shapes.each(&block)
  end

  class Shape; end

  class Rectangle < Shape
    def initialize(a, b)
      @a = a
      @b = b
    end

    def area
      @a * @b
    end

    def output
      [@a, @b]
    end
  end

  class Circle < Shape
    def initialize(r)
      @r = r
    end

    def area
      @r**2 * Math::PI
    end

    def output
      @r
    end
  end

  class << self
    def build_shape(arg)
      case arg
      when Numeric
        Circle.new(arg)
      when Array
        Rectangle.new(*arg)
      else
        raise ArgumentError "invalid argument type"
      end 
    end
  end
end


def sort_by_area(array)
  shapes = Shapes.new(array)
  shapes.sort_by_area!
  shapes.to_output
end

example = [[4.23, 6.43], 1.23, 3.444, [1.342, 3.212]]
binding.irb