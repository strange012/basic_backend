### 2.1. Получить список всех клиентов, зарегистрированных за последние полгода, у кого есть неоплаченные инвойсы

Для этого необходимо найти все `bills` у `clients`, применить фильтр к `clients` по `created_at`, применить фильтр к `bills` по двум полям `status` и `posted_at`. По бизнес логике неоплаченный инвойс - инвойс в статусе `posted` или `partially_paid`, у которого `posted_at` в прошлом.

```ruby
  sql = <<-SQL
    SELECT b.invoice_number
    FROM bills b
    JOIN clients c ON b.client_id = c.id
    WHERE b.status IN (1, 2)
    AND c.created_at > '2023-10-09'
  SQL
```

### 2.2. Получить список всех клиентов, зарегистрированных за последние полгода, у кого есть неоплаченные рекуррентные инвойсы

Та же логика, что и в предыдущем случае, но нужно дополнительно проверять, что у инвойса есть связь с рекуррентным инвойсом. То есть неоплаченный рекуррентный инвойс - рекуррентный инвойс, у которого есть хотя бы один не оплаченный выставленный инвойс (логика из прошлой задачи).

```ruby
  sql = <<-SQL
    SELECT b.invoice_number
    FROM bills b
    JOIN clients c ON b.client_id = c.id
    LEFT JOIN recurring_invoices r ON b.recurring_invoice_id = r.id
    WHERE b.status IN (1, 2)
    AND r.state IN(1, 2)
    AND c.created_at > '2023-10-09'
  SQL
```

### 2.3. Посчитать средний размер инвойса за полгода

Для этого необходимо выбрать все инвойсы за полгода. Далее необходимо агрегировать `amount` с помощью `GROUP BY` и функции среднего.

```ruby
  sql = <<-SQL
    SELECT TO_CHAR(AVG(base_amount), 'FM999999999.9999') AS avg_base_amount, client_id
    FROM bills b
    WHERE b.created_at > '2023-10-09'
    GROUP BY client_id
    ORDER BY client_id
  SQL
```

### 2.4. Посчитать средний размер разового инвойса за полгода без экстримальных значений

Логика как в прошлом случае, но нужно выбрать все инвойсы без рекуррентных инвойсов и пропозалов. Также необходимо отфильтровать экстримальные значения. Например, инвойсы меньше 10 долларов и больше 10000 долларов.

```ruby
  sql = <<-SQL
    SELECT TO_CHAR(AVG(base_amount), 'FM999999999.9999') AS avg_base_amount, client_id
    FROM bills b
    LEFT JOIN contract_bills c ON b.id = c.bill_id
    WHERE b.created_at > '2023-10-09'
    AND b.recurring_invoice_id IS NULL
    AND c.bill_id IS NULL
    AND b.base_amount > 10 AND b.base_amount < 10000
    GROUP BY client_id
    ORDER BY client_id
  SQL
```