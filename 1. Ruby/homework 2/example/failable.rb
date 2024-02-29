module Failable
  class TestFailed < StandardError; end

  [:to, :not_to].each do |meth|
    define_method meth do |matcher|
      super(matcher).tap { escape_if_failed(_1) } 
    end
  end

  private

  def escape_if_failed(result)
    raise TestFailed, "failed test" unless result
  end
end
