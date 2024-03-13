class LinkedList
  class Node
    def initialize(val)
      @val = val
      @next = nil
    end

    attr_accessor :val, :next
  end

  def initialize(array = [])
    @head = nil

    prev_node = nil
    array.each_with_index do |el, idx|
      node = { val: 1, next: nil}
       
      prev_node[:next] = node if prev_node
      @head = node if idx == 0
      
      prev_node = node
    end
  end

  attr_accessor :head

  def find(val)
  end

  def index_of()
  end
end

binding.irb

