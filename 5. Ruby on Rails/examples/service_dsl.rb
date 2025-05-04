require 'active_support'

module Service
  extend ActiveSupport::Concern

  class_methods do
    def call(...)
      new(...).call
    end

    def define_params(*names)
      @@param_names = names
    end
  end

  def initialize(*params)
    @@param_names.zip(params) do |name, param|
      instance_variable_set("@#{name}", param.freeze)
      self.class.attr_reader name
    end
  end
end


class CoolService
  include Service

  define_params :a, :b, :cool_param
  
  def call
    cool_param << 2 # can't modify frozen Array: [1, 2, 3] (FrozenError)
    cool_param = 12 # OK
    @cool_param # [1, 2, 3]
    private_method
  end

  private

  def private_method
    cool_param # [1, 2, 3]
  end
end

CoolService.call(1, 2, [1, 2, 3])