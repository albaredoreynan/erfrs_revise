# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'erfrs'
set :repo_url, 'git@bitbucket.org:appsource/erfrs.git'

# set :log_level, :debug

set :unicorn_workers, 2

set :linked_files, %w{config/database.yml config/initializers/0-env.rb tmp/pids/unicorn.pid log/unicorn.log}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
