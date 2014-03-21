#
# Cookbook Name:: newrelic
# Attributes:: server-monitor-agent
#
# Copyright 2012-2014, Escape Studios
#

default['newrelic']['server-monitor-agent']['service_name'] = "newrelic-sysmond"
default['newrelic']['server-monitor-agent']['service_notify_action'] = :restart
default['newrelic']['server-monitor-agent']['service_actions'] = [:enable, :start] #starts the service if it's not running and enables it to start at system boot time
default['newrelic']['server-monitor-agent']['config_path'] = "/etc/newrelic"
default['newrelic']['server-monitor-agent']['config_file_group'] = "newrelic"
default['newrelic']['server-monitor-agent']['windows_version'] = "2.0.0.198"
default['newrelic']['server-monitor-agent']['windows64_checksum'] = "5a8f3f5e8f15997463430401756d377c321c8899c2790ca85e5587a5b643651e"
default['newrelic']['server-monitor-agent']['windows32_checksum'] = "ac2b65eecaad461fdd2e4386e3e4c9f96ea940b35bdf7a8c532c21dbd1c99ff0"
