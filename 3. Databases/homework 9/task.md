# Задание к уроку Databases (lesson 9)

## 1. Пройти [туториала по Redis](https://redis.io/docs/latest/develop/connect/cli/)

## 2. Локально установить Redis

### Краткая инструкция через `Docker`

Зайти в папку `homework 9`, где лежит `docker-compose.yml`

```bash
docker-compose up -d
docker-compose run redis bash
redis-cli -h redis
```

В терминале `redis-cli` попробовать команды из туториала
