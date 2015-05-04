set :rails_env, :staging
set :branch, :staging
set :deploy_to, '/home/dswd'
set :user, :dswd
set :nginx_server_name, '202.126.43.34'
set :default_env, { 'ERFRS_USES_POSTGRESQL' => 1 } 
set :linked_files, %w[config/database.yml tmp/pids/unicorn.pid log/unicorn.log]
set :linked_dirs, %w{ public/paperclip }

server '202.126.43.34', user: 'dswd', roles: %w[web app]


set :ssh_options, {
  #keys: ["/Users/ken/.ssh/erfrsUser.key"],
  # keys: ["/Users/reynanalbaredo/Downloads/privatekey.pem"],
  auth_methods: %w[password],
  forward_agent: true
}


