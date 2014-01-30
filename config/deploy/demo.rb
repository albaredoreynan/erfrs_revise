set :rails_env, :demo
set :branch, :develop
set :deploy_to,    "/home/azureuser/apps/erfrs"
set :linked_files, %w{config/database.yml}

server 'erfrs-demo.cloudapp.net', user: 'azureuser', roles: %w{web app}

set :ssh_options, {
  keys: %w{/home/ken/.ssh/erfrsUser.key},
  forward_agent: true,
  auth_methods: %w{publickey}
}

