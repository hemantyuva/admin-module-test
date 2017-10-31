lock "3.10.0"

set :application, "studo"
# set :scm, :git
set :repo_url, "git@github.com:hemantyuva/admin-module-test.git"
server '45.55.253.72', user: 'root', roles: %w{web app}, my_property: :my_value, password: 'Stud0S3rv3r54==='
set :deploy_to, '/var/www/admin_module'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default value for :pty is false
set :pty, true

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for keep_releases is 5
set :keep_releases, 5
namespace :deploy do
   desc "start resque"
   task "resque:start" => :app do
         run "cd #{current_path} && RAILS_ENV=#{environment} BACKGROUND=yes PIDFILE=#{shared_path}/pids/resque.pid QUEUE=* nohup bundle exec rake environment resque:work QUEUE='*' >> #{shared_path}/log/resque.out"
    end

    desc "stop resque"
    task "resque:stop" => :app do
         run "kill -9 `cat #{shared_path}/pids/resque.pid`"
    end

   desc "ReStart resque"
   task "resque:restart" => :app do
         Rake::Task['deploy:resque:stop'].invoke
         Rake::Task['deploy:resque:start'].invoke
   end

   desc "start resque scheduler"
   task "resque:start_scheduler" => :app do
         run "cd #{current_path} && RAILS_ENV=#{environment} DYNAMIC_SCHEDULE=true BACKGROUND=yes PIDFILE=#{shared_path}/pids/resque_scheduler.pid QUEUE=* nohup bundle exec     rake environment resque:scheduler >> #{shared_path}/log/resque_scheduler.out"
   end

    desc "stop resque scheduler"
    task "resque:stop_scheduler" => :app do
          run "kill -9 `cat #{shared_path}/pids/resque_scheduler.pid`"
    end

    desc "ReStart resque scheduler"
    task "resque:restart" => :app do
         Rake::Task['deploy:resque:stop_scheduler'].invoke
         Rake::Task['deploy:resque:start_scheduler'].invoke
    end


   desc 'Restart application'
    task :restart do
          on roles(:app), in: :sequence, wait: 5 do
          execute :touch, release_path.join('tmp/restart.txt')
    end
    end

   after :publishing, :restart 

   after :restart, :clear_cache do
   on roles(:web), in: :groups, limit: 3, wait: 10 do
          execute :touch, 'sudo service nginx restart'
   end

  # desc "Update crontab with whenever"
  # task :update_cron do
  #        on roles(:app) do
  #               within current_path do
  #                    execute :bundle, :exec, "whenever --update-crontab #{fetch(:application)}"
  #               end
  #        end
  #  end
  # after :finishing, 'deploy:update_cron'
end
end