# Gemfile

# use rubygems
source 'https://rubygems.org'

# gems for the app itself
gem 'active_attr'
gem 'awesome_print'
gem 'backbone-on-rails'
gem 'backbone_sync-rails'
gem 'cancan'
gem 'faye'
gem 'jquery-rails'
gem 'pg'
gem 'rails', '~> 3.2.12'
gem 'resque'
gem 'simple_form'
gem 'slim-rails'
gem 'sorcery'
gem 'unicorn'
gem 'valid_email'

# asset gems
group :assets do
  gem 'coffee-rails'
  gem 'less-rails'
  gem 'less-rails-bootstrap'
  gem 'libv8', '~> 3.11.8'
  gem 'therubyracer'
  gem 'uglifier'
end

# test gems
group :test, :development do
  gem 'cane'
  gem 'capybara', '~> 2.0'
  gem 'capybara-email'
  gem 'factory_girl_rails'
  gem 'jasminerice'
  gem 'morecane'
  gem 'quiet_assets'
  gem 'rspec-rails', '~> 2.12.0'
  gem 'simplecov'
  gem 'timecop'
end

# dev gems
group :development do
  gem 'foreman'
  gem 'growl'
  gem 'guard'
  gem 'guard-jasmine'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'mailcatcher'
  gem 'rb-fsevent'
end

# This version needs to be hardcoded for OpenShift compatibility
gem 'thor' #, '= 0.14.6'

# This needs to be installed so we can run Rails console on OpenShift directly
gem 'minitest'
