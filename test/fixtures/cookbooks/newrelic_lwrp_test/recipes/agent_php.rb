# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: agent_php
#
# Copyright 2015, Rackspace
#

include_recipe 'apache2'
include_recipe 'php'

newrelic_agent_php 'Install' do
  license node['newrelic']['license']
  app_name 'test_app'
  config_file '/etc/php.d/newrelic.ini'
  startup_mode 'external'
end

# newrelic_agent_php 'remove' do
#  action :remove
# end
