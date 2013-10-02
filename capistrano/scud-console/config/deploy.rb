require "capistrano_colors"
require "find"

set :deploy_to_host, "#{deploy_to_host}"

# app settings
set :application, "isucon-node"
set :repository,  "https://#{git_host}/toru0707/#{application}.git"
set :scm, :git
set :branch, "master"
set :deploy_to, "/opt/#{application}"
set :deploy_via, :copy
set :build_script, "npm install"

role :web, "#{deploy_to_host}"                          
role :app, "#{deploy_to_host}"                          
role :db, "#{deploy_to_host}", :primary => true

ssh_options[:keys] = "#{ssh_key}"
ssh_options[:auth_methods] = %w(publickey)

def remote_file_exists?(path)
  begin
    run "ls #{path}"
    return true
  rescue Exception => e
    return false
  end
end

namespace :deploy do
  before "deploy" do
    try_sudo "chown -R isucon:isucon #{deploy_to}"
  end

  task :start do 
      try_sudo "node start"
  end
  task :stop do 
      try_sudo "node stop"
  end
  task :restart,  :except => { :no_release => true } do
      try_sudo "node stop"
      try_sudo "node start"
  end
end
