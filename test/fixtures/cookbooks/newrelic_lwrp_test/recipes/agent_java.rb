# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: agent_java
#
# Copyright 2012-2015, Escape Studios
#

include_recipe 'java'
include_recipe 'tomcat'

user 'newrelic' do
  action :create
end

newrelic_agent_java 'Install' do
  action node['newrelic']['java_agent']['agent_action']
  license node['newrelic']['license']
  install_dir node['newrelic']['java_agent']['install_dir']
  app_location node['tomcat']['home']
  app_name 'java_test_app'
  class_transformer_config node['newrelic']['java_agent']['class_transformer_config']
end

# newrelic_agent_java 'Remove' do
#   action :remove
# end
