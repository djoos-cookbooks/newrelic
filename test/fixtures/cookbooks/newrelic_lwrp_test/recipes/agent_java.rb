# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: agent_java
#
# Copyright 2015, Rackspace
#

include_recipe 'java'
include_recipe 'tomcat'

newrelic_agent_java 'Install' do
  license node['newrelic']['license']
  app_name 'java_test_app'
end
