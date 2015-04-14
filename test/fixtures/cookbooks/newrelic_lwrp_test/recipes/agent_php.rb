# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: agent_php
#
# Copyright 2012-2015, Escape Studios
#

include_recipe 'apache2'
include_recipe 'php'

newrelic_agent_php 'Install' do
  license node['newrelic']['license']
  service_name node['newrelic']['php_agent']['web_server']['service_name']
  config_file node['newrelic']['php_agent']['php_config']
  startup_mode 'external'
end
