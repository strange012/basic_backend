module TestableHash
  def expect(arg)
    Expect.new(arg)
  end

  def eq(arg)
    { operation: :eq, argument: arg}
  end

  def be_nil
    { operation: :be_nil }
  end    

  def be_empty
    { operation: :be_empty }
  end

  class Expect
    def initialize(obj)
      @obj = obj
    end

    def to(eq)
      res = match(eq)
      print(res)
      res
    end

    def not_to(eq)
      res = !match(eq)
      print(res)
      res
    end

    def match(eq)
      case eq[:operation]
      when :eq
        @obj == eq[:argument]
      when :be_nil
        @obj.nil?
      when :be_empty
        @obj.empty?
      end
    end

    def print(res)
      puts(res ? "OK" : "FAIL")
    end
  end
end


class FooTest
  include TestableHash

  def test(foo)
    binding.irb
    expect(foo).to(eq(1))
    # a + b + (c + d)

    # expect_instance = expect(foo) # Expect(@obj = 1)
    # eq_instance = eq(1) # EqMatcher(@expectation = 1)
    # expect_instance.to(eq_instance)

    expect(foo).not_to eq(2)
    expect(foo).not_to be_nil

    expect([foo]).not_to be_empty
    expect([foo]).to be_empty
  end
end

FooTest.new.test(1)


