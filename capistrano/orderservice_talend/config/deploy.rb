require "capistrano_colors"
require "find"

set :deploy_to_host, "#{mvphosts['scud_host']}"

# app settings
set :application, "orderservice_talend"
set :war_base, "orderservice"
set :repository,  "git@#{git_host}:#{application}.git"
set :scm, :git
set :branch, "master"
set :deploy_to, "/opt/#{application}"
set :deploy_via, :copy
set :tomcat_home, "/var/lib/tomcat7"
set :tomcat_webapps, "#{tomcat_home}/webapps"

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

  task :start do 
        try_sudo "service tomcat7 start"
  end
  task :stop do 
	try_sudo "service tomcat7 stop"
  end
  task :restart,  :except => { :no_release => true } do
	try_sudo "service tomcat7 restart"
  end
end

after "before:update_code" do
  Find.find "." do |file|
    puts file
  end
end

after "deploy:update" do
  try_sudo "rm -fr #{tomcat_webapps}/#{war_base}.war"
  try_sudo "rm -fr #{tomcat_webapps}/#{war_base}"
  try_sudo "ln -s #{current_path}/#{war_base}.war #{tomcat_webapps}/#{war_base}.war"
end
