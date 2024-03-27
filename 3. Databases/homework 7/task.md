# Задание к уроку Databases (lesson 7)

## 1. Пройти блок [SQL Database](https://www.w3schools.com/sql/sql_create_db.asp) курса w3school

## 2. Локально установить PostgreSQL и pgAdmin

### Краткая инструкция через `Docker`

Зайти в папку `homework 7`, где лежит `docker-compose.yml`

```bash
docker-compose up -d
docker-compose run postgres bash
psql -h postgres -d basic_backend -U admin # password: admin
```

В терминале `psql` попробовать создать таблицу, как было в примерах `w3school`

Открыть браузер, перейти на `http://localhost:8888/` и ввести login/password для `pgadmin` из `docker-compose.yml`.

Подключиться к серверу `postgres` (сервис `postgres`, логин и пароль в `docker-compose.yml`)

Проверить, что таблица создалась
