#
# Cookbook Name:: newrelic
# Attributes:: server-monitor
#
# Copyright 2012-2013, Escape Studios
#

default['newrelic']['service_name'] = "newrelic-sysmond"
default['newrelic']['config_path'] = "/etc/newrelic"
default['newrelic']['config_file_group'] = "newrelic"

# targz install  method
default['newrelic']['sysmond_tar_version'] = "1.3.1.437"
default['newrelic']['sysmond_tar_baseurl'] = "https://download.newrelic.com/server_monitor/release/newrelic-sysmond"
