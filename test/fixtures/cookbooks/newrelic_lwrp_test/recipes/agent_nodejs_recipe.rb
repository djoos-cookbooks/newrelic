#
# Cookbook Name:: newrelic_lwrp_test
# Recipe:: agent_nodejs_recipe
#
# Copyright (c) 2016, David Joos
#

# version one dot thirty eight dot two has invalid readable stream version two dot two dot three
nodeapp = { 'app_path' => '/var/mynode_app', 'app_name' => 'My Node Application', 'app_log_level' => 'info', 'app_log_filepath' => '/var/mynode_app/newrelic.log', 'version' => '1.37.2' }
node.default['newrelic']['nodejs_agent']['apps'] = [nodeapp]

directory '/var/mynode_app' do
  mode '0755'
  recursive true
  action :create
end

include_recipe 'nodejs'
include_recipe 'newrelic::nodejs_agent'
