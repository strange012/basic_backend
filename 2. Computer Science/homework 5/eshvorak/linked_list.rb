class Node
  attr_accessor :value, :next_node

  def initialize(value)
    @value = value
    @next_node = nil
  end
end

class LinkedList
  class InvalidArgumentsError < StandardError; end

  attr_reader :head, :tail  

  def initialize(array = []) # прописал изначальное состояние массива в случае если забыли передать аргументы
    @head = nil
    @tail = nil
    create_list(array) # сразу создаем лист из массива при инициализации
  end

  def to_array # метод для обратного извлечения массива из списка
    values = []
    current_node = @head # в данном случае head - начало уже сформированного linked_list
    while current_node != nil # nil - будет последним узлом согласно условия формирования листа в методе create_list
      values << current_node.value # сунем в массив значение текущего узла
      current_node = current_node.next_node # идем к след узлу
    end
    values
  end

  def [](index)
    search_by(index, 'node by index')
  end

  def find(value)
    search_by(value, 'node by value')
  end

  def index_of(node)
    search_by(node, 'index by node')
  end

  
  def insert(value, index)
    raise InvalidArgumentsError, 'Index not found' unless index <= list_size

    if @head.nil?
      @head = Node.new(value)
      @tail = @head
    elsif index == 0
      new_node = Node.new(value)
      new_node.next_node = @head
      @head = new_node
    elsif index == list_size - 1 # придумал упрощение в случае если мы добавляем в конец массива. но по факту при каждом добавлении будет высчитываться list_size что на большом списке с большим количеством вызовов insert вызовет боль =\
      self << value
    else
      node_after_added = self[index]
      prev_node = self[index - 1]
      new_node = Node.new(value)  
      prev_node.next_node = new_node
      new_node.next_node = node_after_added
    end
  end

  def push(value)
    if @head.nil? # в случае если список пустой - создаем узел и добавляем туда элемент
      @head = Node.new(value)
      @tail = @head
    else
      @tail.next_node = Node.new(value)
      @tail = @tail.next_node
    end
  end

  alias << push

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

  # def search_by(criteria_arg, type) # запилил херню и рад. просидел 2 часа думая как сделать код более эффективным не внося 3 условия в цикл, не придумал
  #   current_node = @head
  #   current_index = 0
# 
  #   case type
  #   when 'node by index'
  #     while current_node != nil
  #       return current_node if current_index == criteria_arg
# 
  #       current_node = current_node.next_node
  #       current_index += 1
  #     end
# 
  #   when 'node by value'
  #     while current_node != nil
  #       return current_node if current_node.value == criteria_arg
# 
  #       current_node = current_node.next_node
  #       current_index += 1
  #     end
  #     
  #   when 'index by node'
  #     while current_node != nil
  #       return current_index if current_node == criteria_arg
# 
  #       current_node = current_node.next_node
  #       current_index += 1
  #     end
  #   end
# 
  #   return nil
  # end
  
  def search_by(criteria_arg, type) # решение чат гпт через лямбда функции. выглядит красиво
    operation = {
      'node by index' => ->(node, index) { node if index == criteria_arg },
      'node by value' => ->(node, _) { node if node.value == criteria_arg },
      'index by node' => ->(node, index) { index if node == criteria_arg }
    }
  
    current_node = @head
    current_index = 0
  
    while current_node != nil
      result = operation[type].call(current_node, current_index)
      return result if result
  
      current_node = current_node.next_node
      current_index += 1
    end
  
    nil
  end
  
  def list_size
    return 0 if @head.nil?

    current_node = @head
    length = 0

    while current_node != nil
      current_node = current_node.next_node
      length += 1
    end
    length
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
list.insert(:aa, 3)
list.insert(:aa, 0)
list.insert(:aa, 7)

puts list.to_array.inspect