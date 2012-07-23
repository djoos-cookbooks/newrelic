#
# Cookbook Name:: newrelic
# Recipe:: server-monitor
#
# Copyright 2012, Escape Studios
#

#install the server monitor
package "newrelic-sysmond" do
	action :install
end

#configure your New Relic license key
execute "newrelic-nrsysmond-config" do
	command "nrsysmond-config --set license_key=#{node[:newrelic][:license_key]}"
	action :run
end

service "newrelic-sysmond" do
    supports :status => true, :start => true, :stop => true, :restart => true
	action [:enable, :start] #starts the service if it's not running and enables it to start at system boot time
end