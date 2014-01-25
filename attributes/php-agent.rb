#
# Cookbook Name:: newrelic
# Attributes:: php-agent
#
# Copyright 2012-2014, Escape Studios
#

default['newrelic']['startup_mode'] = "agent"
default['newrelic']['web_server']['service_name'] = "apache2"
default['newrelic']['php_recipe'] = "php::default"