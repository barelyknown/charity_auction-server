source "https://rubygems.org"
ruby "2.2.3"

gem "rails", "4.2.4"
gem "pg"
gem "bcrypt", "~> 3.1.7"
gem "puma"
gem "doorkeeper"
gem "jsonapi-resources", ">= 0.6.0"
gem "rack-cors", :require => "rack/cors"
gem "apitome"

group :development, :test do
  gem "byebug"
end

group :development do
  gem "spring"
  gem "spring-commands-rspec"
end

group :development, :test do
  gem "rspec-rails", "~> 3.0"
  gem "factory_girl_rails"
  gem "rspec_api_documentation"
  gem "shoulda-matchers", "~> 3.0"
end

group :production do
  gem "rails_12factor"
end
