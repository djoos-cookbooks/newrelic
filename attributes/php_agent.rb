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
default['newrelic']['php_agent']['execute_php5enmod'] = false
default['newrelic']['php_agent']['template']['cookbook_ini'] = 'newrelic'
default['newrelic']['php_agent']['template']['source_ini'] = 'agent/php/newrelic.ini.erb'
default['newrelic']['php_agent']['template']['cookbook'] = 'newrelic'
default['newrelic']['php_agent']['template']['source'] = 'agent/php/newrelic.cfg.erb'
