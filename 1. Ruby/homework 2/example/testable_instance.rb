module TestableInstance
  def expect(arg)
    Expect.new(arg)
  end

  def eq(arg)
    Eq.new(arg)
  end

  def be_gt(arg)
    BeGt.new(arg)
  end

  def be_nil
    BeNil.new
  end    

  def be_empty
    BeEmpty.new
  end

  def array_match(array)
    ArrayMatch.new(array)
  end

  class Eq
    def initialize(arg)
      @arg = arg
    end

    def match?(obj)
      @arg == obj
    end
  end

  class BeGt
    def initialize(arg)
      @arg = arg
    end

    def match?(obj)
      obj > @arg 
    end
  end

  class BeNil
    def match?(obj)
      obj.nil?
    end
  end

  class BeEmpty
    def match?(obj)
      obj.empty?
    end
  end

  class ArrayMatch
    def initialize(array)
      @array = array
    end

    def match?(obj)
      obj.sort == @array.sort
    end
  end

  class Expect
    def initialize(obj)
      @obj = obj
    end

    def to(matcher)
      res = match(matcher)
      print(res)
      res
    end

    def not_to(matcher)
      res = !match(matcher)
      print(res)
      res
    end

    def match(matcher)
      matcher.match?(@obj)
    end

    def print(res)
      puts(res ? "OK" : "FAIL")
    end
  end
end


class FooTest
  include TestableInstance

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
    expect(2).to be_gt(3)
  
    expect([3, 2, 1]).to array_match([1, 2, 3])
  end
end

FooTest.new.test(1)


