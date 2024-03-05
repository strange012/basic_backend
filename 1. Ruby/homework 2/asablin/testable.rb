# frozen_string_literal: true

module Testable
  def expect(value)
    
    Expectation.new(value)
  end

  class Expectation
    def initialize(value)
      @value = value
    end

    def to(matcher)
      
      if matcher.match?(@value)
        puts 'OK'
      else
        puts 'FAIL'
      end
    end

    def not_to(matcher)
      if matcher.match?(@value)
        puts 'FAIL'
      else
        puts 'OK'
      end
    end
  end

  class EqMatcher
    def initialize(expected)
      @expected = expected
    end

    def match?(actual)
      
      actual == @expected
    end
  end

  class NilMatcher
    def match?(actual)
      actual.nil?
    end
  end

  class EmptyMatcher
    def match?(actual)
      actual.empty?
    end
  end

  def eq(expected)
    
    EqMatcher.new(expected)
  end

  def be_nil
    NilMatcher.new
  end

  def be_empty
    EmptyMatcher.new
  end
end

class FooTest
  include Testable

  def test(foo)
    expect(foo).to eq(1)
    expect(foo).not_to eq(2)
    expect(foo).not_to be_nil

    expect([foo]).not_to be_empty
    expect([foo]).to be_empty
  end
end

FooTest.new.test(1)
