# Databases block homework (lesson 8)

## 1. Complete the [SQL Tutorial section](https://www.w3schools.com/sql/default.asp) of the w3school course

## 2. Write queries for the TaxDome database

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

### 2.1. Get a list of all clients registered in the last six months who have unpaid invoices

For this, you need to find all `bills` for `clients`, apply a filter to `clients` by `created_at`, apply a filter to `bills` by two fields: `status` and `posted_at`. According to business logic, an unpaid invoice is an invoice with status `posted` or `partially_paid`, which has `posted_at` in the past.

### 2.2. Get a list of all clients registered in the last six months who have unpaid recurring invoices

The same logic as in the previous case, but you need to additionally check that the invoice has a connection with a recurring invoice. That is, an unpaid recurring invoice is a recurring invoice that has at least one unpaid issued invoice (logic from the previous task).

### 2.3. Calculate the average invoice size for the last six months

For this, you need to select all invoices for the last six months. Then you need to aggregate `amount` using `GROUP BY` and the average function.

### 2.4. Calculate the average size of a one-time invoice for the last six months without extreme values

The logic is the same as in the previous case, but you need to select all invoices without recurring invoices and proposals. You also need to filter out extreme values. For example, invoices less than 10 dollars and more than 10000 dollars.
