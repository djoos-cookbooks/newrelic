# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: agent_nodejs
#
# Copyright 2012-2015, Escape Studios
#

include_recipe 'nodejs'

directory '/var/mynode_app' do
  mode '0755'
  recursive true
  action :create
end

newrelic_agent_nodejs '/var/mynode_app' do
  license node['newrelic']['license']
  app_name 'my_nodejs_app'
  enabled false
  app_log_level 'debug'
  app_log_filepath '/var/mynode_app/mylog.log'
end

# newrelic_agent_nodejs '/var/mynode_app' do
#   license node['newrelic']['license']
#   action :remove
# end
