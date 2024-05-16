# Задание к уроку Ruby on Rails (lesson 14)

## Развернуть локально Rails приложение

Использовать команду [`rails new`](https://guides.rubyonrails.org/command_line.html#rails-new) для генерации нового приложения. В документации описаны возможные параметры.

Папка удаляется и процедура повторяется ровно столько раз, сколько потребуется для достижения желаемого эффекта :)

Для запуска из докера следует перекинуть `Dockerfile` и `docker-compose.yml` в корень проекта. Заменяем в `Dockerfile` RUBY_VERSION на текущую версию руби. Далее запускаем:

```bash
docker-compose up rails
```

Далее заходим в брауер, вводим `http://localhost:3000/`, и видим красивую эмблему Rails. Поздравляю, мы запустили локально приложение!

## Дополнительно. Подключить к приложению PostgreSQL из докера, который был настроен в третьем блоке

В `docker-compose.yml` уже прописаны все зависимости для настройки PostgreSQL. Для подключения базы необходимо сгенерировать `rails new` с аргументом `--database=postgresql`. После чего повторить все шаги из предыдущего блока.

Далее необходимо подключить `Rails` к базе, для этого заходим в `config/database.yml` и в блоке `default` добавляем такие аргументы:

```yaml
host: <%= ENV['DATABASE_HOST'] || 'localhost' %>
database: basic_backend
username: admin
password: admin
```

Сохраняем и поднимаем заново приложение:

```bash
docker-compose up rails
```

Далее заходим в контейнер с приложением и запускаем `Rails` консоль:

```bash
docker-compose exec -it rails bash
rails c
```

Проверяем, что база подключена. Команда должна вернуть актуальные настройки соединения.

```ruby
ActiveRecord::Base.connection
```

Далее можно пользоваться базой, как в дз про запросы:

```ruby
sql = <<-SQL
  # вставить сюда запрос
SQL

ActiveRecord::Base.connection.execute(sql).to_a
```
