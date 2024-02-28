module Testable
    class Expectation
  
      def initialize(obj)
          @obj = obj
      end
  
      def to(matcher)
          matcher.match?(@obj)
      end
  
      def not_to(matcher)
          !matcher.match?(@obj)
      end
    end
  
    class EqMatcher
      def initialize(expectation)
          @expectation = expectation
      end
  
      def match?(value)
          value = @expectation
      end
    end
  
    def expect(obj)
      Expectation.new(subject)
    end
  
    def eq(expected)
      EqMatcher.new(expected)
    end
  
    class BeNilMatcher
      def match?(actual)
        actual.nil?
      end
    end
  
    class BePresentMatcher
      def match?(actual)
        !actual.respond_to?(:empty?) && !actual.empty?
      end
    end
  
    class BeEmptyMatcher
      def match?(actual)
        actual.respond_to?(:empty?) && actual.empty?
      end
    end
  
    class BeTruthyMatcher
      def match?(actual)
        actual.true?
      end
    end
  
    class BeFalseyMatcher
      def match?(actual)
        actual.false?
      end
    end
  
    class BeSuccessfulMatcher
      def match?(actual)
        (200..299).to_a.include?(actual["code"])
      end
    end
  
    def be_nil
      BeNilMatcher.new
    end
  
    def be_present
      BePresentMatcher.new
    end
    
    def be_empty
      BeEmptyMatcher.new
    end
  
    def be_truthy
      BeTruthyMatcher.new
    end
  
    def be_falsey
      BeFalseyMatcher.new
    end
  
    def be_successful
      BeSuccessfulMatcher.new
    end
  end