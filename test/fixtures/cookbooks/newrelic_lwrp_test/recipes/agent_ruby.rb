# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: agent_java
#
# Copyright 2015, Rackspace
#
#

include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'
ruby_version = '2.1.2'

rbenv_ruby ruby_version do
  global true
end

newrelic_agent_ruby 'Install' do
  license node['newrelic']['license']
  agent_type 'ruby'
  app_name 'ruby_test_app'
end

# newrelic_agent_ruby 'Remove' do
#   action :remove
# end
