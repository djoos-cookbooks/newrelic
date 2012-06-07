#
# Cookbook Name:: newrelic
# Recipe:: php-agent
#
# Copyright 2012, Escape Studios
#

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

#restart newrelic-daemon
execute "newrelic-daemon" do
	command "/etc/init.d/newrelic-daemon restart"
	action :run
end

#restart apache
case node['platform']
	when "debian", "ubuntu"
		apache_service_name = "apache2"
	when "redhat", "centos", "fedora"
		apache_service_name = "httpd"
end

service "#{apache_service_name}" do
	supports :restart => true, :reload => true
	action [:start]
end