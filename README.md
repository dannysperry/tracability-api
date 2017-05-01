# How to Install

I have included a step by step guide in this README on how I set this up. But if you just want to get up and running, here are the steps:

## Setup Project
1. Run `bundle install`
2. Run `bundle exec rake db:create db:migrate db:seed; RAILS_ENV=test bundle exec rake db:drop db:create db:migrate`

## Run Server
1. Boot up the server with `rails s` and navigate to localhost:3000 to see your new rails application

## Run Tests
1. Start your tests with `bundle exec rspec`. This will automatically generate a coverage report.

## Create API Docs
1. While the server is running, generate API documentation provided to /docs/ with `bundle exec rails docs:generate`

## Deploy
1. push your code to master to deploy to gh-pages

### Generator

#### Rest Resource Generator

I've provided a `rest_resource` generator. It's main purpose is to closely lay out a scaffold of tests, api docs, and files for a new route and model.

ex: `bundle exec rails g rest_resource Project description:text email phone_number production_url staging_url state:integer`

Double check the attributes inside
  1. the migration file
  2. factories
  3. controller safe params
  4. acceptance specs attributes
  5. model specs associated with any active record associations/validations made.
  6. Run `bundle exec rails db:migrate RAILS_ENV=test` and `bundle exec rails db:migrate`
  7. 

