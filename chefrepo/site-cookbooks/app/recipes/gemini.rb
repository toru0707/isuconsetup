user "gemini" do
	comment "gemini user"
	gid "cumulo"
	home "/home/gemini"
	shell "/bin/bash"
	password "$1$xiDAR1cZ$CtMHkrTtu7Q.kptAbRWWU0"
	supports :manage_home => true
end 

directory "/home/gemini/documents/orders/2013" do
	mode "0755"
	owner "gemini"
	group "gemini"
	recursive true
	action :create
end

#sshd password_login = ok
service "ssh" do
        supports :status => true, :restart => true, :reload => true
	action :restart
end
template 'sshd_config' do
	path '/etc/ssh/sshd_config'
        source  'sshd_config.erb'
        owner   'root'
        group   'root'
        mode    '0600'
        notifies :restart, 'service[ssh]'
end
