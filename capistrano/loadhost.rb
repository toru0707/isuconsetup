# coding: utf-8

#mvp用のhost部分をhashへ格納
set :mvphosts , {}
is_mvphost = false
open("../../etc/hosts","r").each do |line|
	if is_mvphost && !line.empty? then
		ip, host = line.split(" ")
		mvphosts[host.split(".")[0] + "_host"] = ip
	end
	if line=~/# mvp hosts/ then
		is_mvphost = true	
	end
end
