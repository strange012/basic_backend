module ShapeSorter
    def self.sort_by_area(arg)
        arg.sort_by do |shape|
            if shape.is_a?(Array)
                shape[0] * shape[1]
            else
                Math::PI * shape**2
            end
        end
        p arg
    end
end


ShapeSorter.sort_by_area([[2, 5], 6])
