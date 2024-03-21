# Задание к уроку Computer Science (lesson 5)

## Реализовать связный список в руби

- Реализовать класс `LinkedList`
  - `LinkedList` хранит ссылку на корневой узел, а также методы итерации
  - Каждый узел хранит значение и ссылку на следующий узел
- Определить конструктор класса, который создает связный список из массива

  ```ruby
    LinkedList.new([1, 2, 3]) # <LinkedList [1, 2, 3]>
    LinkedList.new # <LinkedList []>
  ```

- Определить метод `[]` для получения узла по индексу

   ```ruby
    list = LinkedList.new([1, 2, 3]) # <LinkedList [1, 2, 3]>
    list[2] # <Node 3>
    list[100] # nil
  ```

- Определить метод `find` для поиска узла по значению

   ```ruby
    list = LinkedList.new([1, 2, 3]) # <LinkedList [1, 2, 3]>
    list.find(3) # <Node 3>
    list.find(5) # nil
  ```

- Определить метод `index_of` для поиска индекса узла

   ```ruby
    list = LinkedList.new([1, 2, 3]) # <LinkedList [1, 2, 3]>
    node = list.find(2) # <Node 2>

    list.index_of(node) # 1
    list.index_of(Node.new(12)) # nil
  ```

- Определить метод `insert` для вставки элемента или узла на место указанного индекса

   ```ruby
    list = LinkedList.new([1, 2, 3]) # <LinkedList [1, 2, 3]>
    
    list.insert(4, 2) # 
    list.insert(Node.new(5), 1)# <LinkedList [1, 5, 2, 3, 4]> 
  ```

- Определить метод `push` для вставки элемента или узла в конец массива. Объявить alias на метод `<<`

   ```ruby
    list = LinkedList.new([1, 2, 3]) # <LinkedList [1, 2, 3]>

    list.push(4) # <LinkedList [1, 2, 3, 4]>
    list << Node.new(5) # <LinkedList [1, 2, 3, 4, 5]> 
  ```

## Дополнительное задание

- Определить метод `to_list` у массива

  ```ruby
    [1, 2, 3].to_list # <LinkedList [1, 2, 3]>
  ```

- Включить в реализацию класса `LinkedList` модуль `Enumerable`

- Определить метод `delete` для удаления узла из связного списка

   ```ruby
    list = LinkedList.new([1, 2, 3]) # <LinkedList [1, 2, 3]>

    node = list.find(2) # <Node 3>
    list.delete(node) # <LinkedList [1, 3]>
  ```
