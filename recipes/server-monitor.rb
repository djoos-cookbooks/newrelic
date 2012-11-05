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
template "/etc/newrelic/nrsysmond.cfg" do
	source "nrsysmond.cfg.erb"
	owner "root"
	group "newrelic"
	mode "640"
	variables(
		:license_key => node[:newrelic][:license_key]
	)
	notifies :restart, "service[newrelic-sysmond]"
end

service "newrelic-sysmond" do
    supports :status => true, :start => true, :stop => true, :restart => true
	action [:enable, :start] #starts the service if it's not running and enables it to start at system boot time
end