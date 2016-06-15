
# Cookbook Name:: newrelic
# Recipe:: docker_agent
#
# Copyright 2012-2015, Escape Studios
#

include_recipe 'newrelic::server_monitor_agent'

service node['newrelic']['docker_agent']['service_name'] do
  :nothing
end

service 'newrelic-sysmond' do
  :nothing
end

group node['newrelic']['docker_agent']['app_group'] do
  action :create
  members node['newrelic']['docker_agent']['app_user']
  append true
  notifies :restart, "service[#{node['newrelic']['docker_agent']['service_name']}]", :delayed
  notifies :restart, 'service[newrelic-sysmond]', :delayed
end
