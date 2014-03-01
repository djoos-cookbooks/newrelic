#
# Cookbook Name:: newrelic
# Attributes:: server-monitor
#
# Copyright 2012-2014, Escape Studios
#

default['newrelic']['service_name'] = "newrelic-sysmond"
default['newrelic']['service_notify_action'] = :restart
default['newrelic']['service_actions'] = [:enable, :start] #starts the service if it's not running and enables it to start at system boot time
default['newrelic']['config_path'] = "/etc/newrelic"
default['newrelic']['config_file_group'] = "newrelic"
