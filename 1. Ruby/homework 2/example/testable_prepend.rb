module TestablePrepend
  def eq(arg)
    Eq.new(arg)
  end
  
  def be_nil
    BeNil.new
  end
  
  def be_empty
    BeEmpty.new
  end
  
  class Eq
    ARITY = 2

    def initialize(obj)
      @obj = obj
    end

    attr_accessor :obj
  
    def match?(subj)
      @obj == subj
    end
  end
  
  class BeNil
    ARITY = 1

    def match?(subj)
      subj.nil?
    end
  end
  
  class BeEmpty
    ARITY = 1

    def match?(subj)
      subj.empty?
    end
  end

  class Expect
    def initialize(obj)
      @obj = obj
    end
  
    def to(matcher)
      match(matcher)
    end
  
    def not_to(matcher)
      !match(matcher)
    end

    private

    def match(matcher)
      matcher.match?(@obj)
    end
  end

  def expect(arg)
    Expect.new(arg)
  end
end

class FooTest
  include TestablePrepend

  def test(foo)
    expect(foo).to(eq(1))
    expect(foo).not_to eq(2)
    expect(foo).not_to be_nil

    expect([foo]).not_to be_empty
    expect([foo]).to be_empty
  end
end

FooTest.new.test(1)
