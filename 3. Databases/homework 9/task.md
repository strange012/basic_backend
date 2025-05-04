# Databases block homework (lesson 9)

## 1. Complete the lesson 8 homework

## 2. Write additional queries

All queries can be tested locally or on the staging database. Simply copy your query to the buffer, enter the rails console, and save the `SQL` code in a variable:

```ruby
  sql = <<-SQL
    # insert your query here
  SQL
```

Then execute the query:

```ruby
  ActiveRecord::Base.connection.execute(sql).to_a
```

You can add `EXPLAIN ANALYZE` at the beginning of the query to get the execution plan and time.

### 2.1. Get a list of clients with overdue payments (any) for the last six months. Calculate the number, average amount, and total amount of payments for each client

A payment is considered `overdue` if it was not paid within 5 days of being issued (regardless of whether it was paid or not). We count six months based on the issue date, not the payment date.

### 2.2. Calculate the average nesting level in folders for documents

Here you need to recursively join `doc_dirs` to itself to build a directory tree. Then join with `documents` and group with aggregation by nesting level. The nesting level will have to be calculated independently during the recursive join.
