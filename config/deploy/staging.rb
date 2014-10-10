set :rails_env, :staging
set :branch, :staging
set :deploy_to, '/home/ubuntu'
set :user, :ubuntu
set :nginx_server_name, 'erfrs.dswd.gov.ph'
set :default_env, { 'ERFRS_USES_POSTGRESQL' => 1 } 
set :linked_files, %w[config/database.yml tmp/pids/unicorn.pid log/unicorn.log]
set :linked_dirs, %w{ public/paperclip }

server 'erfrs.dswd.gov.ph', user: 'ubuntu', roles: %w[web app]


set :ssh_options, {
  #keys: ["/Users/ken/.ssh/erfrsUser.key"],
  #auth_methods: %w[password],
  forward_agent: true
}


