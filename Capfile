
require "capistrano/setup"

require "capistrano/deploy"
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rvm'
require 'capistrano/rails/migrations'
require 'capistrano/rails/assets'

# require 'capistrano/sidekiq'  


require "capistrano/scm/git"

set :rvm_type, :user
set :rvm_ruby_version, '2.4.2'

install_plugin Capistrano::SCM::Git

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }