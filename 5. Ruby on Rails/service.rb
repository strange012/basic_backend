require 'active_support'

module Service
  extend ActiveSupport::Concern

  class_methods do
    def call(...)
      obj = new(...)
      obj.validate!
      obj.authorize!
      obj.call
    end
  end

  def success(data)
    Result.new(:success, data)
  end

  def failure(errors)
    Result.new(:failure, errors)
  end
  
  class Result
    def initialize(status, data)
      case status
      when :success
        @data = data
      when :failure
        @errors = data
      end

      @status = status
    end

    def successful?
      @status == :success
    end

    def failed?
      @status == :failure
    end
  end
end


class CoolService
  include Service

  def initialize(a, b, cool_param)
    @a = a
    @b = b
    @cool_param = @cool_param
  end

  def validate!
    a_valid?
    b_valid?
  end

  def authorize!
    Policy.authorize!(:user, :can_do_smth)
  end
  
  def call
    @cool_param << 2 # OK
    @cool_param = 12 # OK
    private_method
    success(1)
    failure(:error)
  end

  private

  def private_method
    @cool_param # 12
  end
end

CoolService.call(1, 2, [1, 2, 3])

Service.call(params) == Service.new(params).call
