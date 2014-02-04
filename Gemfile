source 'https://rubygems.org'

gem 'rake', '10.0.4'
gem 'rails', '4.0.2'

gem 'devise'
gem 'has_scope'
gem 'inherited_resources', git: 'https://github.com/josevalim/inherited_resources.git'
gem 'will_paginate', '~> 3.0.5'

#if ENV['ERFRS_USES_POSTGRESQL']
  # Nad if you want to use postgresql locally, simply execute the ff 3 commands:
  # echo 'export ERFRS_USES_POSTGRESQL=1' >> ~/.zshrc
  # source ~/.zshrc
  # bundle install
  gem 'pg'
#else
#  gem 'tiny_tds'
#  gem 'activerecord-sqlserver-adapter', git: 'https://github.com/rails-sqlserver/activerecord-sqlserver-adapter.git'
#end

gem 'jquery-rails'
gem 'slim-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'cocoon'

group :development, :test do
  gem 'rspec-rails'   
end

group :test do
  gem 'capybara'
  gem 'guard'
  gem 'guard-rspec'
  gem 'rb-fsevent'
  gem 'shoulda-matchers'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'selenium-webdriver'
end

group :development do
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'awesome_print', require: false

  gem 'capistrano', '3.1.0'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', '~> 1.0.0', require: false
end

group :production do
  gem 'rails_12factor'
end

