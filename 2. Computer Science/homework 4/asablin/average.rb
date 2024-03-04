module Average
    def self.print_average(marks)
        raise ArgumentError, "Argument must be an array" unless marks.is_a?(Array) 
        raise ArgumentError, "Array is empty" unless marks.length > 0
         (marks.reduce(:+) / marks.length).floor
    end
end

Average.print_average([25, 24, 23, 22]) 
Average.print_average([])
Average.print_average(2)