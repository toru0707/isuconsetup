require "capistrano_colors"
require "bundler/capistrano"

ssh_options[:keys] = "#{ssh_key}"
ssh_options[:auth_methods] = %w(publickey)

# this config is needed, if there is no Gemfile.lock on a project.
set :bundle_flags, "--quiet"

# app settings
set :application, "taurus"
set :repository,  "git@#{git_host}:#{application}.git"
set :scm, :git
set :branch, "master"
set :deploy_to, "/opt/#{application}"
set :rails_env, "development"
set :deploy_via, :copy
set :pid, "server.pid"

set :deploy_to_host, "#{mvphosts['virgo_host']}"
role :web, "#{deploy_to_host}"                          
role :app, "#{deploy_to_host}"                          
role :db, "#{deploy_to_host}", :primary => true

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

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do 
        run "cd #{current_path} && RAILS_ENV=#{rails_env} rails s -d --pid #{deploy_to}/#{pid}"
  end
  task :stop do 
	if remote_file_exists?("#{deploy_to}/#{pid}")
		run "kill -9 `cat #{deploy_to}/#{pid}`"
	end
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
	deploy::stop
	deploy::start
  end
  task :seed do
	run "cd #{current_path} && bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
end

after :deploy, "deploy:migrate"
after :deploy, "deploy:seed"
after :deploy, "deploy:cleanup"


