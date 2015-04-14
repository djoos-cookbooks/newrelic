#
# Cookbook Name:: newrelic
# Recipe:: php_agent
#
# Copyright 2012-2015, Escape Studios
#

newrelic_agent_php 'Install' do
  license node['newrelic']['license']
  service_name node['newrelic']['webserver']['service_name']
  config_file node['newrelic']['php_config']
end
