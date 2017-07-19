#
# Cookbook Name:: newrelic_lwrp_test
# Recipe:: agent_java
#
# Copyright (c) 2016, David Joos
#

include_recipe 'java'

tomcat_install 'java_test_app' do
  tomcat_user 'tomcat_user'
  tomcat_group 'tomcat_group'
end

newrelic_agent_java 'Install' do
  license node['newrelic']['license']
  install_dir node['newrelic']['java_agent']['install_dir']
  version node['newrelic']['java_agent']['version']
  app_name 'java_test_app'
  app_user 'root'
  app_group 'root'
  class_transformer_config node['newrelic']['java_agent']['class_transformer_config']
end

# newrelic_agent_java 'Remove' do
#   action :remove
# end
