module MyModule
  def instance_method
    puts 'module 2'
    2
  end

  def do_all_and_print
   a = 1 + 1
   b = 2 + 3
   c = a * b
   puts  c
  end

  def step1
   1 + 1
  end

  def step2
    2 + 3
  end

  def step3(s1, s2)
    sleep(1)
    s1 * s2
  end

  def print_steps
   puts step3(step1, step2)
  end
end

module TimeTrackable  
  def step1
    t = Time.now
    result = super
    puts "step 1 time spent: #{Time.now - t}"
    result
  end

  def step2
    t = Time.now
    result = super
    puts "step 2 time spent: #{Time.now - t}"
    result 
  end

  
end

class C

  def self.print_something
    puts "Something"
  end

  def self.define_my_method
    define_method :step_instance do
      puts "I'm not predefined"
    end
  end
end

class A < C
  define_my_method

  def self.included(base)
    extend(self, base.class)
  end

  include MyModule
  prepend TimeTrackable
  extend MyModule

  def instance_method
    super
  end

  def step1
    100 + 150
  end

  def step2
    600 * 5000
  end

  def step3(*args)
    t = Time.now
    result = super(*args)
    puts "step 3 time spent: #{Time.now - t}"
    result
  end

  def self.step_class
    560 * 4
  end

  class << self
    def step_class_2
      300 * 23
    end
  end

  private

  def private_step
    puts "I'am private"
  end
end

class B
  include MyModule
  prepend TimeTrackable
end


binding.irb
