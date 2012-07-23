#
# Cookbook Name:: newrelic
# Recipe:: php-agent
#
# Copyright 2012, Escape Studios
#

# Execute apache2 receipe + mod_php5 receipe
include_recipe "php"
include_recipe "apache2"
include_recipe "apache2::mod_php5"

#install the php agent
package "newrelic-php5" do
	action :install
end

#run newrelic-install
execute "newrelic-install" do
	command "newrelic-install install"
	action :run
end

#configure your New Relic license key
template "/etc/newrelic/newrelic.cfg" do
	source "newrelic.cfg.erb"
	owner "root"
	group "root"
	mode "0644"
	variables(
		:license_key => node[:newrelic][:license_key]
	)
	action :create
end

#starts and enables at boot the newrelic-daemon then restarts apache2
service "newrelic-daemon" do
  supports :status => true, :start => true, :stop => true, :restart => true
  action [:enable, :start]
  notifies :restart, "service[apache2]", :delayed
end