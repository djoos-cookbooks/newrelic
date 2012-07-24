#
# Cookbook Name:: newrelic
# Recipe:: python-agent
#
# Copyright 2012, Escape Studios
#

include_recipe "python::pip"

# install latest python agent
python_pip "newrelic" do
  action :install
end

#configure your New Relic license key
template "/etc/newrelic/newrelic.ini" do
	source "newrelic.python.erb"
	owner "root"
	group "root"
	mode "0644"
	variables(
		:license_key => node[:newrelic][:license_key],
		:app_name => node[:newrelic][:app_name]
	)
	action :create
end