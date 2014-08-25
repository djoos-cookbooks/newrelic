#
# Cookbook Name:: newrelic
# Attributes:: php_agent
#
# Copyright 2012-2014, Escape Studios
#

default['newrelic']['php_agent']['agent_action'] = :install
default['newrelic']['php_agent']['install_silently'] = false
default['newrelic']['php_agent']['startup_mode'] = 'agent'
default['newrelic']['php_agent']['web_server']['service_name'] = 'apache2'
default['newrelic']['php_agent']['config_file'] = nil
