source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 6.1.4", ">= 6.1.4.1"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.2"
# Use Puma as the app server
gem "puma", "~> 5.0"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem "jbuilder", "~> 2.7"
# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"
# Use Active Model has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Use Active Storage variant
# gem "image_processing", "~> 1.2"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

# Draper adds an object-oriented layer of presentation logic to your Rails apps. Read more: https://github.com/drapergem/draper
gem "draper", "~> 4.0", ">= 4.0.2"

# The official AWS SDK for Ruby for SQS
gem "aws-sdk-sqs", "~> 1.48"

# Shoryuken is a super efficient AWS SQS thread based message processor
gem "shoryuken", "~> 5.3"

# Slim templates generator for Rails
gem "slim-rails"

# Simple, but flexible HTTP client library, with support for multiple backends
gem "faraday"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "parallel_tests"
  gem "pry-rails"
  gem "rspec-rails"
end

group :test do
  gem "capybara"
  gem "rubocop-rspec", require: false
  gem "shoulda-matchers"
  gem "simplecov"
  gem "webmock"
end

group :development do
  gem "foreman"
  gem "listen", "~> 3.3"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "spring"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
