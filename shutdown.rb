#!/usr/bin/ruby
# coding: utf-8

# launch ec2
TERMINATE_CMD = %q(vagrant destroy)

puts "# start to terminate ec2!"
homedir = Dir.pwd
pids = []
Dir.glob("vagrant/*").each do |dir|
	host = dir.split('/')[1]
	if host == "etc" then next end
	puts "	terminating #{host}..."
	Dir.chdir(homedir + "/" + dir)

	# create subprocesses	
	pids << fork do	
		IO.popen(TERMINATE_CMD, "r+").each do |l|
			puts l
		end
	end
end

# check if all subprocesses are succeeded.
results = Process.waitall
results.each do |r|
	raise unless pids.include?(r[0]) && r[1].success?
end	
puts "# finish to terminate!"

