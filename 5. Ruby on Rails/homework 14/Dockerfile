# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.3.0
FROM --platform=linux/amd64 ruby:$RUBY_VERSION as base

ENV workdir /app
WORKDIR $workdir

COPY --chown=root:root . $workdir

RUN bundle install

CMD ["bundle", "exec", "bin/rails", "s", "-b", "0.0.0.0", "-p", "3000"]
