module Service
  def self.included(base)
    base.extend self
  end

  def call(*args)
    new(*args).call
  end
end


class CoolService
  include Service

  def initialize(cool_params)
    @cool_params = cool_params
  end

  def call
    puts @cool_params
  end
end

CoolService.call(a: :is_cool, b: :is_ok, you: :are_bad)
