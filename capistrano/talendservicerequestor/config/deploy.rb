require "capistrano_colors"
require "find"

set :deploy_to_host, "#{mvphosts['scud_host']}"

# app settings
set :application, "talendservicerequestor"
set :repository,  "git@#{git_host}:#{application}.git"
set :scm, :git
set :branch, "master"
set :deploy_to, "/opt/#{application}"
set :deploy_via, :copy

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
    try_sudo "chown -R cumulo:cumulo #{deploy_to}"
  end
end

after "before:update_code" do
  Find.find "." do |file|
    puts file
  end
end

