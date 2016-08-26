#
# Cookbook Name:: newrelic
# Attributes:: php_agent
#
# Copyright (c) 2016, David Joos
#

default['newrelic']['php_agent']['agent_action'] = nil
default['newrelic']['php_agent']['install_silently'] = nil
default['newrelic']['php_agent']['startup_mode'] = nil
default['newrelic']['php_agent']['web_server']['service_name'] = nil
default['newrelic']['php_agent']['web_server']['service_action'] = nil
default['newrelic']['php_agent']['web_server']['service_provider'] = nil
default['newrelic']['php_agent']['web_server']['service_supports'] =  {:status => true, :start => true, :stop => true, :restart => true, :reload => true}
default['newrelic']['php_agent']['config_file'] = nil
default['newrelic']['php_agent']['config_file_to_be_deleted'] = nil
default['newrelic']['php_agent']['execute_php5enmod'] = nil
default['newrelic']['php_agent']['template']['cookbook_ini'] = nil
default['newrelic']['php_agent']['template']['source_ini'] = nil
default['newrelic']['php_agent']['template']['cookbook'] = nil
default['newrelic']['php_agent']['template']['source'] = nil
default['newrelic']['php_agent']['additional_config'] = {}
