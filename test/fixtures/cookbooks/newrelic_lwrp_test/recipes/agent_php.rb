#
# Cookbook Name:: newrelic_lwrp_test
# Recipe:: agent_php
#
# Copyright (c) 2016, David Joos
#

include_recipe 'apache2'

node.set['php']['pear'] = 'pear'
include_recipe 'php'

newrelic_agent_php 'Install' do
  license node['newrelic']['license']
  service_name node['newrelic']['php_agent']['web_server']['service_name']
  config_file node['newrelic']['php_agent']['php_config']
  enable_module node['newrelic']['php_agent']['enable_module']
  execute_php5enmod node['newrelic']['php_agent']['execute_php5enmod']
  startup_mode 'external'
end
