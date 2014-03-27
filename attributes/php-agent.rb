#
# Cookbook Name:: newrelic
# Attributes:: php-agent
#
# Copyright 2012-2014, Escape Studios
#

php_ext_conf_dir = nil

if node.attribute?('php')
	if node['php'].attribute?('ext_conf_dir')
		php_ext_conf_dir = node['php']['ext_conf_dir']
  	end
end

default['newrelic']['php-agent']['startup_mode'] = "agent"
default['newrelic']['php-agent']['web_server']['service_name'] = "apache2"
default['newrelic']['php-agent']['php_recipe'] = "php::default"
default['newrelic']['php-agent']['config_file'] = "#{php_ext_conf_dir}/newrelic.ini"
