#
# Cookbook Name:: newrelic_lwrp_test
# Recipe:: lwrp_yml
#
# Copyright (c) 2016, David Joos
#

include_recipe 'java'

tomcat_install 'java_test_app' do
  tomcat_user 'tomcat_user'
  tomcat_group 'tomcat_group'
end

newrelic_yml "#{node['newrelic']['java_agent']['install_dir']}/newrelic.yml" do
  app_name 'java_test_app'
  agent_type 'java'
end
