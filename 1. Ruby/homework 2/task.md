## Задание к уроку Ruby (lesson 2) 

### You need to implement DSL for matching things. Following code has to work:

```ruby
Module Testable
  # your code here
end

Class FooTest
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

# Console output:
# OK
# OK
# OK
# OK
# FAIL
```

- Module `Testable` have to be implemented
- Console output could match the example but it's not requiered. It serves mostly as an example
- Syntax should be similar to `rspec` (like in the example)
- Any improvements are welcome but not necessary 
