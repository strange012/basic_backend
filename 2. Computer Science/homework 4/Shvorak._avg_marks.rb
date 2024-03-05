module FindAverageHelper
    def sum_of(obj)
        Summarizer.new(obj)
    end

    class Summarizer
        def initialize(obj)
            @obj = obj
        end

        def sum
            sum = 0
            @obj.each do |el|
                sum += el
            end
            sum
        end

        def divide_to(divisor)
           result = sum / divisor
           puts result
           result
        end
    end
end

def get_average(marks)
    include FindAverageHelper
    return sum_of(marks).divide_to marks.length
end

def generate_random_array(size, min_value, max_value)
    array = Array.new(size) { rand(min_value..max_value) }
    puts array
    array
end

get_average(generate_random_array(10, 1, 100))



module AverageComputer
    def sum_of(array)
        sum = 0
        array.each do |el|
            sum += el
        end
        sum
    end

    def avg(array)
        sum_of(array) / array.size
    end
end

module ArrayAverage
    include AverageComputer
    def average
        avg(self).tap { |x| puts x }
    end
end

Array.prepend ArrayAverage