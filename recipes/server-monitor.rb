#
# Cookbook Name:: chef-newrelic
# Recipe:: server-monitor
#
# Copyright 2012, Escape Studios
#

case node[:platform]
	when "debian", "ubuntu"
		#install the server monitor
		package "newrelic-sysmond" do
			action :install
		end

		#configure your New Relic license key
		execute "nrsysmond-config" do
			command "nrsysmond-config --set license_key=#{node[:newrelic][:license_key]}"
			action :run
		end

		#start nrsysmond
		service "newrelic-sysmond" do
			supports :restart => true, :status => true
			#supports :start => true, :stop => true, :restart => true, :reload => false, :force-reload => true, :status => true, :force-stop => true
			#starts the service if it's not running and enables it to start at system boot time
			action [:enable, :start]
		end
end