source "https://rubygems.org"

gem "rails", "5.2"

gem "puma"
gem "redis"

gem "annotate"
gem "bootstrap-sass"
gem "devise"
gem "draper"
gem "haml-rails"
gem "jquery-rails"
gem "sass-rails"
gem "sqlite3"
gem "uglifier"

# http calls
gem "faraday"
gem "oj"

gem "fast_jsonapi"

# dry
gem "dry-auto_inject"
gem "dry-container"
gem "dry-matcher"
gem "dry-monads"
gem "dry-validation"

# jobs
gem "sidekiq"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "bullet"
  gem "letter_opener"
  gem "pry-rails"
  gem "rails-erd"
  gem "spring"
  gem "spring-commands-rspec"
end

group :development, :test do
  gem "awesome_print"
  gem "factory_bot_rails"
  gem "faker"
  gem "listen"
  gem "rspec-rails"
  gem "simplecov"
end

group :test do
  # http calls
  gem "vcr"
  gem "webmock"

  # sockets
  gem "action-cable-testing"

  gem "shoulda-matchers"

  # system spec
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :lint do
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end
