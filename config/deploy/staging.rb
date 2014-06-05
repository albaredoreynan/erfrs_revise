set :rails_env, :staging
set :branch, :staging
set :deploy_to, '/home/azureuser'
set :user, :azureuser
set :nginx_server_name, 'dswd-erfrs.cloudapp.net'

# set :linked_files, %w[config/database.yml tmp/pids/unicorn.pid log/unicorn.log]

server 'dswd-erfrs.cloudapp.net', user: 'azureuser', roles: %w[web app]

set :ssh_options, {
  #keys: ["/Users/ken/.ssh/erfrsUser.key"],
  #auth_methods: %w[password],
  forward_agent: true
}


