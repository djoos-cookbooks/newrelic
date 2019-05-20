#
# Cookbook Name:: newrelic_lwrp_test
# Recipe:: agent_nodejs
#
# Copyright (c) 2016, David Joos
#

include_recipe 'nodejs'

directory '/var/mynode_app' do
  mode '0755'
  recursive true
  action :create
end

newrelic_agent_nodejs '/var/mynode_app' do
  license node['newrelic']['license']
  # version one dot thirty eight dot two has invalid readable stream version two dot two dot three
  version '1.37.2'
  app_name 'my_nodejs_app'
  enabled false
  app_log_level 'debug'
  app_log_filepath '/var/mynode_app/mylog.log'
end

# newrelic_agent_nodejs '/var/mynode_app' do
#   license node['newrelic']['license']
#   action :remove
# end
