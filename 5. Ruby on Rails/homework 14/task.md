# Ruby on Rails block homework (lesson 14)

## Deploy a Rails application locally

Use the [`rails new`](https://guides.rubyonrails.org/command_line.html#rails-new) command to generate a new application. The documentation describes possible parameters.

The folder is deleted and the procedure is repeated exactly as many times as needed to achieve the desired effect :)

To run from Docker, you should transfer the `Dockerfile` and `docker-compose.yml` to the project root. Replace RUBY_VERSION in the `Dockerfile` with the current Ruby version. Then run:

```bash
docker-compose up rails
```

Next, go to the browser, enter `http://localhost:3000/`, and see the beautiful Rails emblem. Congratulations, we have launched the application locally!

## Additional task: Connect the application to PostgreSQL from Docker, which was configured in the third block

The `docker-compose.yml` already has all the dependencies for setting up PostgreSQL. To connect the database, you need to generate `rails new` with the argument `--database=postgresql`. Then repeat all the steps from the previous section.

Next, you need to connect `Rails` to the database. To do this, go to `config/database.yml` and add these arguments to the `default` block:

```yaml
host: <%= ENV['DATABASE_HOST'] || 'localhost' %>
database: basic_backend
username: admin
password: admin
```

Save and restart the application:

```bash
docker-compose up rails
```

Next, enter the application container and launch the `Rails` console:

```bash
docker-compose exec -it rails bash
rails c
```

Check that the database is connected. The command should return the current connection settings.

```ruby
ActiveRecord::Base.connection
```

Then you can use the database as in the homework about queries:

```ruby
sql = <<-SQL
  # insert your query here
SQL

ActiveRecord::Base.connection.execute(sql).to_a
```
