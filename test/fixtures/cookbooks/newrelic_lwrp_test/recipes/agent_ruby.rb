#
# Cookbook Name:: newrelic_lwrp_test
# Recipe:: agent_java
#
# Copyright (c) 2016, David Joos
#

package 'ruby'

package node['rubygems'] do
  action :install
end

newrelic_agent_ruby 'Install' do
  license node['newrelic']['license']
  app_name 'ruby_test_app'
  app_user 'root'
  app_group 'root'
  version node['newrelic']['ruby_agent']['version']
end

# newrelic_agent_ruby 'Remove' do
#   action :remove
# end
