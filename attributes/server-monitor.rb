#
# Cookbook Name:: newrelic
# Attributes:: server-monitor
#
# Copyright 2012-2014, Escape Studios
#

default['newrelic']['server-monitor']['service_name'] = "newrelic-sysmond"
default['newrelic']['server-monitor']['service_notify_action'] = :restart
default['newrelic']['server-monitor']['service_actions'] = [:enable, :start] #starts the service if it's not running and enables it to start at system boot time
default['newrelic']['server-monitor']['config_path'] = "/etc/newrelic"
default['newrelic']['server-monitor']['config_file_group'] = "newrelic"
