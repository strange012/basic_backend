require 'active_support'
require 'dry-initializer'

module Service
  extend ActiveSupport::Concern

  included do
    extend Dry::Initializer
  end

  class_methods do
    def call(...)
      new(...).call
    end
  end
end


class CoolService
  include Service

  param :a, reader: :private
  param :b, reader: :private
  param :cool_param, [], reader: :private

  def call
    cool_param << 2 # OK
    cool_param = 12 # OK
    @cool_param # [1, 2, 3, 2]
    private_method
  end

  private

  def private_method
    cool_param # [1, 2, 3, 2]
  end
end

CoolService.call(1, 2, [1, 2, 3])