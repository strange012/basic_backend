class Config
  class UndefinedAttribute < StandardError; end

  class << self
    def instance
      @instance ||= new
    end

    def build(&block)
      instance.tap { |x| x.instance_eval(&block) }
    end

    def build_nested(&block)
      new.tap { |x| x.instance_eval(&block) }
    end
  end

  def method_missing(method, *args, &block)
    value = block_given? ? self.class.build_nested(&block) : args[0]
    
    raise UndefinedAttribute unless value

    singleton_class.attr_accessor method
    instance_variable_set("@#{method}", value)
  end
end


def config
  Config.instance
end


Config.build do
  site_name 'TaxDome'
  email {
    pop {
      address 'pop.example.com'
      port 110
    }
    smtp {
      address 'smtp.example.com'
      port 25
    }
  }
end

binding.irb