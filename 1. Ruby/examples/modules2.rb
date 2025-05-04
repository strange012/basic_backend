module A
  def foo
    p "A"
    super
  end
end

module B
  def foo
    p "B"
  end
end

class Foo
  prepend A
  include B

  def foo
    p "Foo"
    super
  end

  def boo
    p "boo"
  end
end

binding.irb