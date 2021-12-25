source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.5"

gem "bootsnap", require: false
gem "brakeman"
gem "bundler-audit"
gem "cssbundling-rails"
gem "delayed"
gem "devise"
gem "dotenv-rails"
gem "foreman"
gem "haml"
gem "jsbundling-rails"
gem "kaminari"
gem "mina"
gem "puma", "~> 5.0"
gem "rubocop"
gem "rails", "~> 7.0.0"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "redis", "~> 4.0"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
