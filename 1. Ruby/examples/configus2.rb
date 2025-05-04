class Config
  class UndefinedKeyError < StandardError; end

  def self.build(&block)
    @instance = new(&block)
  end

  def self.instance
    @instance
  end

  def initialize(&block)
    @state = {}
    instance_eval(&block)
  end

  def method_missing(key, *args, &block)
    key = key.to_s
    val = block_given? ? self.class.new(&block) : args.first
    val.nil? ? read(key) : write(key, val)
  end

  def write(key, val)
    @state[key] = val
  end

  def read(key)
    raise UndefinedKeyError unless respond_to?(key)
    @state[key]
  end

  def respond_to?(method_name, include_private = false)
    @state.include?(method_name.to_s) || super
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