# Задание к уроку Databases (lesson 9)

## 1. Доделать задание к уроку 8

## 2. Написать дополнительные запросы

Все запросы можно потестировать локально или на базе стейджинга. Достаточно скопировать свой запрос в буфер, зайти в rails консоль и сохранить `SQL` код в переменную:

```ruby
  sql = <<-SQL
    # вставить сюда запрос
  SQL
```

Далее необходимо выполнить запрос:

```ruby
  ActiveRecord::Base.connection.execute(sql).to_a
```

Можно добавить в начало запроса `EXPLAIN ANALYZE`, чтобы получить план и время исполнения.

### 2.1. Получить список клиентов c просроченными ИНВОЙСАМИ (любыми) за последние полгода. Посчитать количество, среднюю сумму и общую сумму ИНВОЙСОВ для каждого клиента

ИНВОЙС считается `overdue`, если не был оплачен в течение 5 дней с момента выставления (независимо от того, был ли он оплачен). Полгода считаем по дате выставления, а не по дате оплаты.


```ruby
  sql = <<-SQL
  SELECT c.id, c.account_name, COUNT(b.id) AS bills_count, TO_CHAR(AVG(b.amount), 'FM999999999.9999') AS avg_bill_amount, TO_CHAR(SUM(b.amount), 'FM999999999.9999') AS all_bills_amount
  FROM clients c
  JOIN bills b ON c.id = b.client_id
  WHERE b.posted_at >= CURRENT_DATE - INTERVAL '6 months'
    AND b.state IN (0, 1, 2, 3) 
    AND (c.paid_at > c.posted_at + INTERVAL '5 days')
  GROUP BY 
    c.id
  SQL

```

### 2.2. Посчитать средний уровень вложенности в папки для документов

Тут необходимо рекурсивно заджоинить в себя `doc_dirs`, чтобы построить дерево директорий. Далее джоин с `documents` и группировка с агрегацией по уровню вложенности. Уровень вложенности придется считать самостоятельно во время рекурсивного джоина.


```ruby
  sql = <<-SQL
    WITH RECURSIVE dir_hierarchy AS 
    (
    SELECT id, parent_id, path, 1 AS depth
    FROM doc_dirs
    WHERE parent_id IS NULL

    UNION ALL

    SELECT dd.id,dd.parent_id, dd.path, dh.depth + 1
    FROM doc_dirs dd
    JOIN dir_hierarchy dh ON dd.parent_id = dh.id
    )
    SELECT TO_CHAR(AVG(depth), 'FM999999999.9999') AS average_depth
    FROM dir_hierarchy dh
    JOIN documents d ON dh.id = d.doc_dir_id
    GROUP BY dh.id;
  SQL
```