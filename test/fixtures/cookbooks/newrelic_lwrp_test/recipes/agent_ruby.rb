# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: agent_java
#
# Copyright 2012-2015, Escape Studios
#

include_recipe 'ruby'

package node['rubygems'] do
  action :install
end

newrelic_agent_ruby 'Install' do
  license node['newrelic']['license']
  app_name 'ruby_test_app'
end

# newrelic_agent_ruby 'Remove' do
#   action :remove
# end
