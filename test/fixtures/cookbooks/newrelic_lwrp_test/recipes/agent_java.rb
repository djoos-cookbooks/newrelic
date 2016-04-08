# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: agent_java
#
# Copyright 2012-2015, Escape Studios
#

include_recipe 'java'
include_recipe 'tomcat'

newrelic_agent_java 'Install' do
  license node['newrelic']['license']
  install_dir node['newrelic']['java_agent']['install_dir']
  app_location node['tomcat']['home']
  app_name 'java_test_app'
end

# newrelic_agent_java 'Remove' do
#   action :remove
# end
