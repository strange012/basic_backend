module MyEnumerable
  def each(&block); raise NotImplementedError; end
  def size; raise NotImplementedError; end

  def each_with_index(&block)
    idx = 0
    each do |el|
      yield el, idx
      idx += 1
    end
  end

  def reduce(acc = nil, &block)
    each do |el|
      acc = acc ? yield(acc, el) : el
    end
    acc
  end

  def map(&block)
    result = Array.new(size)
    
    each_with_index { |el, idx| result[idx] = yield el }
    result
  end
end

module MyIterable
  def size
    @arr.size
  end
end

class MyArray
  include MyEnumerable
  include MyIterable

  def initialize(arr)
    @arr = arr
  end
 
  def each(&block)
    @arr.each(&block)
  end
end

class MyHash
  include MyEnumerable
  include MyIterable
end

[1,2 ,3 ,4] => Array

Enumerable

binding.irb
