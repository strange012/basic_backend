require_relative 'parent'
require_relative 'child'

parent1 = Parent.new('John', 'Smith', 44)
parent2 = Parent.new('Elizabeth','Smith',35)

child = Child.new('Emily','Smith', 12)

parent1.say_your_name
parent1.info
parent2.say_your_last_name
child.info
child.say_your_name