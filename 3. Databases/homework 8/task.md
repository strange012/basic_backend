# Задание к уроку Databases (lesson 8)

## 1. Пройти блок [SQL Tutorial](https://www.w3schools.com/sql/default.asp) курса w3school

## 2. Написать запросы к базе TaxDome

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

### 2.1. Получить список всех клиентов, зарегистрированных за последние полгода, у кого есть неоплаченные инвойсы

Для этого необходимо найти все `bills` у `clients`, применить фильтр к `clients` по `created_at`, применить фильтр к `bills` по двум полям `status` и `posted_at`. По бизнес логике неоплаченный инвойс - инвойс в статусе `posted` или `partially_paid`, у которого `posted_at` в прошлом.

### 2.2. Получить список всех клиентов, зарегистрированных за последние полгода, у кого есть неоплаченные рекуррентные инвойсы

Та же логика, что и в предыдущем случае, но нужно дополнительно проверять, что у инвойса есть связь с рекуррентным инвойсом. То есть неоплаченный рекуррентный инвойс - рекуррентный инвойс, у которого есть хотя бы один не оплаченный выставленный инвойс (логика из прошлой задачи).

### 2.3. Посчитать средний размер инвойса за полгода

Для этого необходимо выбрать все инвойсы за полгода. Далее необходимо агрегировать `amount` с помощью `GROUP BY` и функции среднего.

### 2.4. Посчитать средний размер разового инвойса за полгода без экстримальных значений

Логика как в прошлом случае, но нужно выбрать все инвойсы без рекуррентных инвойсов и пропозалов. Также необходимо отфильтровать экстримальные значения. Например, инвойсы меньше 10 долларов и больше 10000 долларов.
