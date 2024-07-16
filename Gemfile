source "https://rubygems.org"

ruby "3.3.0"

gem "rails"
gem "pg"
gem "puma"
gem "graphql"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
gem "sprockets-rails", require: "sprockets/railtie"
gem "rack-cors"
gem "devise"
gem "jwt"
gem "dotenv-rails"
gem "graphiql-rails"

# Use for seed
gem "factory_bot_rails"
gem "faker"

group :development, :test do
  gem "debug", platforms: %i(mri windows)
  gem "rspec-rails"
end

group :test do
  gem "shoulda-matchers"
end
