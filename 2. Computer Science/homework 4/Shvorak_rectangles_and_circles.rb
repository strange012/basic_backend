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
  