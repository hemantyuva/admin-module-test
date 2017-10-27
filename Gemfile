source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg'
# gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '3.8.2'
gem 'figaro'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', platforms: :ruby
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # gem 'capistrano'
  # gem 'capistrano3-puma'
  # gem 'capistrano-rails', require: false
  # gem 'capistrano-bundler', require: false
  # gem 'capistrano-rvm'
  # gem 'capistrano-rbenv'
end
gem 'listen'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'devise'
gem 'momentjs-rails'
gem 'pry'
gem 'carrierwave' # used for image upload

group :production do
  gem 'rails_12factor'
end
# gem 'rmagick'
# gem 'cloudinary'
gem "font-awesome-rails"
gem 'jquery-timepicker-rails'
gem 'simple_token_authentication', '~> 1.0'
gem "pundit"
gem 'ransack'
gem "select2-rails"
gem 'roo'
gem "spreadsheet"


group :development do
   gem "capistrano"
   gem 'net-ssh'
   gem 'capistrano-bundler'
   gem 'capistrano-rails'
   gem 'capistrano-rvm'
   gem 'capistrano-sidekiq'
end