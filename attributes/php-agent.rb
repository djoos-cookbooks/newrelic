#
# Cookbook Name:: newrelic
# Attributes:: php-agent
#
# Copyright 2012-2013, Escape Studios
#

default['newrelic']['startup_mode'] = "agent"
default['newrelic']['web_server']['service_name'] = "apache2"
default['newrelic']['php_recipe'] = "php::default"

# targz install  method
default['newrelic']['php_tar_version'] = "4.3.5.33"
# full url exemple https://download.newrelic.com/php_agent/release/newrelic-php5-4.3.5.33-linux.tar.gz
default['newrelic']['php_tar_baseurl'] = "https://download.newrelic.com/php_agent/release/newrelic-php5"
