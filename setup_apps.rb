#!/usr/bin/ruby
# coding: utf-8

PROVISION_SHELL_CMD = "vagrant provision --provision-with=shell"
DEPLOY_SETUP_CMD = "cap deploy:setup"
DEPLOY_CMD = "cap deploy"
homedir = Dir.pwd

# setting hosts
puts "##############################################"
puts "# start to configure hosts file on each vms! #"
puts "##############################################"
pids = []
Dir.glob("#{homedir}/vagrant/*").each do |dir|
	host = dir.split('/').last
	if host == "etc" then next end
	puts "	configuring #{host}..."
	Dir.chdir(dir)

	# create subprocesses	
	pids << fork do	
		IO.popen(PROVISION_SHELL_CMD, "r+").each do |l|
			puts l
		end
	end
end

# check if all subprocesses are succeeded.
results = Process.waitall
results.each do |r|
	raise unless pids.include?(r[0]) && r[1].success?
end	

puts "##############################################"
puts "# finish to configure"
puts "##############################################"


puts "##############################################"
puts "# start to deploy applications! #"
puts "##############################################"

# deploy apps 
def deploy(app_dir_path)
	app_name = app_dir_path.split('/').last
	puts "	deploying #{app_name}"	
	if !File.directory?(app_dir_path) then return end 
	puts "	ok : #{app_dir_path}"
	Dir.chdir(app_dir_path)
	IO.popen(DEPLOY_SETUP_CMD, "r+").each do |l|
		puts l
	end
	IO.popen(DEPLOY_CMD, "r+").each do |l|
		puts l
	end
end

# regarding to dependencies, deploy sdbs first.
Dir.glob("#{homedir}/capistrano/sdbs").each do |dir|
	deploy(dir)
end

pids = []
# deploy:setup
Dir.glob("#{homedir}/capistrano/*").each do |dir|
	app_name = dir.split('/').last
	next if !File.directory?(dir) || app_name == "sdbs" 
	puts "	deploy:setup #{app_name}"	
	Dir.chdir(dir)

	# create subprocesses	
	pids << fork do	
		IO.popen(DEPLOY_SETUP_CMD, "r+").each do |l|
			puts l
		end
	end
end

# check if all subprocesses are succeeded.
results = Process.waitall
results.each do |r|
	next if !pids.include?(r[0])
	puts "r0 : #{r[0]}"
	puts "r1 : #{r[1]}"
	raise unless pids.include?(r[0]) && r[1].success?
end	

# deploy(デプロイはプロセスが競合するので単一サーバ内で並行して行えない)
Dir.glob("#{homedir}/capistrano/*").each do |dir|
	app_name = dir.split('/').last
	next if !File.directory?(dir) || app_name == "sdbs"

	puts "	deploy #{app_name}"	
	Dir.chdir(dir)

	# create subprocesses	
	IO.popen(DEPLOY_CMD, "r+").each do |l|
		puts l
	end
end

puts "##############################################"
puts "# finish to deploy"
puts "##############################################"

