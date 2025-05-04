# Computer Science block homework (lesson 5)

## Implement a linked list in Ruby

- Implement a LinkedList class
  - `LinkedList` stores a reference to the root node, as well as iteration methods
  - Each node stores a value and a reference to the next node
- Define a class constructor that creates a linked list from an array

  ```ruby
    LinkedList.new([1, 2, 3]) # <LinkedList [1, 2, 3]>
    LinkedList.new # <LinkedList []>
  ```

- Define a `[]` method to get a node by index

   ```ruby
    list = LinkedList.new([1, 2, 3]) # <LinkedList [1, 2, 3]>
    list[2] # <Node 3>
    list[100] # nil
  ```

- Define a `find` method to search for a node by value

   ```ruby
    list = LinkedList.new([1, 2, 3]) # <LinkedList [1, 2, 3]>
    list.find(3) # <Node 3>
    list.find(5) # nil
  ```

- Define an `index_of` method to find the index of a node

   ```ruby
    list = LinkedList.new([1, 2, 3]) # <LinkedList [1, 2, 3]>
    node = list.find(2) # <Node 2>

    list.index_of(node) # 1
    list.index_of(Node.new(12)) # nil
  ```

- Define an `insert` method to insert an element or node at the specified index

   ```ruby
    list = LinkedList.new([1, 2, 3]) # <LinkedList [1, 2, 3]>
    
    list.insert(4, 2) # 
    list.insert(Node.new(5), 1)# <LinkedList [1, 5, 2, 3, 4]> 
  ```

- Define a `push`  method to insert an element or node at the end of the array. Declare an alias for the `<<` method

   ```ruby
    list = LinkedList.new([1, 2, 3]) # <LinkedList [1, 2, 3]>

    list.push(4) # <LinkedList [1, 2, 3, 4]>
    list << Node.new(5) # <LinkedList [1, 2, 3, 4, 5]> 
  ```

## Extra task

- Define a `to_list` method for array

  ```ruby
    [1, 2, 3].to_list # <LinkedList [1, 2, 3]>
  ```

- Include the `Enumerable` module in the `LinkedList` class implementation

- Define a `delete` method to remove a node from the linked list

   ```ruby
    list = LinkedList.new([1, 2, 3]) # <LinkedList [1, 2, 3]>

    node = list.find(2) # <Node 3>
    list.delete(node) # <LinkedList [1, 3]>
  ```
