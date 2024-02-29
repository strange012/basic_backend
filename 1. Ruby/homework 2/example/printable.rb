module Printable
  # def to(matcher)
  #   super(matcher).tap { |res| print_result(res, output(matcher, :to)) } 
  # end

  # def not_to(matcher)
  #   super(matcher).tap { |res| print_result(res, output(matcher, :not_to)) } 
  # end
  [:to, :not_to].each do |meth|
    define_method meth do |matcher|
      super(matcher).tap { print_result(_1, output(matcher, meth)) } 
    end
  end

  private

  def output(matcher, meth)
    binding.irb
    operation = matcher.class.to_s.split('::').last.split(/(?=[A-Z])/).join(' ').downcase
    obj = @obj
    text = "#{obj} #{meth.to_s.split('_').join(' ')} #{operation}"
    text = text + " #{matcher.obj}" if (matcher.class::ARITY == 2)
    text
  end

  def print_result(result, text)
    puts(result ? "OK #{text}" : "FAIL #{text}")
  end
end
