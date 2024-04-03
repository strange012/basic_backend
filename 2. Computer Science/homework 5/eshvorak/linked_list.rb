class Node
  attr_accessor :value, :next_node

  def initialize(value)
    @value = value
    @next_node = nil
  end
end

class Array
  def to_list
    LinkedList.new(self)
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail  

  def initialize(array = []) # прописал изначальное состояние массива в случае если забыли передать аргументы
    @head = nil
    @tail = nil
    create_list(array) # сразу создаем лист из массива при инициализации
  end

  def to_a # метод для обратного извлечения массива из списка
    map(&:value)
  end
  
  def each
    current_node = @head
    while current_node
      yield current_node
      current_node = current_node.next_node
    end
  end

  def [](index)
    search_by do |curr_node, curr_idx|
      return curr_node if curr_idx == index
    end
  end

  def find(value)
    search_by do |curr_node|
      return curr_node if curr_node.value == value
    end
  end

  def index_of(node)
    search_by do |curr_node, curr_idx|
      return  curr_idx if curr_node == node
    end
  end

  
  def insert(value, position) # не смог осилить как вставить ноду. вместо вставки она удаляла к чертям предыдущую ноду
    val_node = Node.new(value)

    if position.zero?
      val_node.next_node = @head
      @head = val_node
      @tail = val_node unless @tail
    else
      pos_node = self[position - 1]

      val_node.next_node = pos_node.next_node
      pos_node.next_node = val_node
      @tail = val_node unless val_node.next_node
    end
  end

  def push(value)
    insert(value, index_of(@tail) + 1)
  end

  alias << push

  def delete(node)
    return if @head.nil? || node.nil?

    if @head == node
      @head = @head.next_node
      @tail = nil if @head.nil?
      return
    end

    current_node = @head
    while current_node.next_node != node && current_node.next_node != nil
      current_node = current_node.next_node
    end

    unless current_node.next_node.nil?
      current_node.next_node = current_node.next_node.next_node
      @tail = current_node if current_node.next_node.nil?
    end
  end

  private

  def create_list(array)
    return if array.empty? # возвращаем пустой объект если нет из чего его создать. Сделано чтобы в будущем мы могли добавить первый элемент в пустой список

    @head = Node.new(array.first) # работаем с первым эл-том массива. Создаем ему узел где будет храниться value 1 элемента и next_node = nil
    @tail = @head # делаем его сразу же хвостом

    current_node = @head
    array[1..-1].each do |el| # проход по всем элементам массива. начинаем со второго
      new_node = Node.new(el)
      current_node.next_node = new_node # присваиваем ссылке на следующий узел текущего узла новое значение и оновременно создаем следующий узел. сейчас у нас второй элемент массива. как помним у нас есть первый узел ( value 1, next_node = nil ). Его next_node становится объектом - новый узел. Получаем узлы ( value 1, next_node = %ссылка на след узел% ) и ( value 2, next_node = nil ).
      current_node = new_node # здесь переходим на следующий узел ( value 2, next_node = nil ). если дальше есть элементы - снова создаем след узел (value = 3, next_node = nil) и присваиваем текущему узлу его значение в next_node (value 2, next_node = %след узел% ). потом на этой строке присваиваем текущему узлу значение созданного узла (value = 3, next_node = nil). и так пока не кончатся элементы
    end
    @tail = current_node
  end

  def search_by(&block) # решение чат гпт через лямбда функции. выглядит красиво
    each_with_index do |node, idx|
      block.call(node, idx)
    end
  end
  
  def list_size
    count = 0
    each { |_| count += 1 }
    count
  end
  
end

list = LinkedList.new(%w[2213 12321321 213213213])

list << 1
list << 2
list << 3

p list[4]
p list[6]

p list.find(1)
p list.find("213213213")
p list.find(213213213)

node_to_find = list.head.next_node.next_node
p list.index_of(node_to_find)

list.insert(:a1, 3)
list.insert(:a2, 0)
list.insert(:a3, 7)

list.push(:a4)
list << :a5

puts [1, 2, 3].to_list

node_to_delete = list.find(:a5)
list.delete(node_to_delete)

list.to_a
binding.irb