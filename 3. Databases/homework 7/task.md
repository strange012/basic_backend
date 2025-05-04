# Databases block homework (lesson 7)

## 1. Complete the [SQL Database section](https://www.w3schools.com/sql/sql_create_db.asp) of the w3school course

## 2. Locally install PostgreSQL and pgAdmin

### Brief instructions using `Docker`

Go to the `homework 7` folder, where the `docker-compose.yml` file is located

```bash
docker-compose up -d
docker-compose run postgres bash
psql -h postgres -d basic_backend -U admin # password: admin
```

In the `psql` terminal, try creating a table as shown in the `w3school` examples

Open a browser, go to `http://localhost:8888/` and enter the login/password for `pgadmin` from `docker-compose.yml`.

Connect to the `postgres` server (service `postgres`, login and password in `docker-compose.yml`)

Verify that the table was created
