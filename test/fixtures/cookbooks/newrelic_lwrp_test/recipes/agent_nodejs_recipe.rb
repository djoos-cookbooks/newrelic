# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: agent_nodejs_recipe
#
# Copyright 2012-2015, Escape Studios
#

nodeapp = { 'app_path' => '/var/mynode_app', 'app_name' => 'My Node Application', 'app_log_level' => 'info', 'app_log_filepath' => '/var/mynode_app/newrelic.log' }
node.default['newrelic']['nodejs_agent']['apps'] = [nodeapp]

directory '/var/mynode_app' do
  mode '0755'
  recursive true
  action :create
end

include_recipe 'nodejs'
include_recipe 'newrelic::nodejs_agent'
