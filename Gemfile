source "https://rubygems.org"

gem "rails", "5.2"

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

# dry
gem "dry-monads"

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
  gem "capybara"
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

  gem "shoulda-matchers"
end

group :lint do
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end
