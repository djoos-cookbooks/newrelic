#
# Cookbook Name:: newrelic
# Attributes:: server_monitor_agent
#
# Copyright 2012-2014, Escape Studios
#

default['newrelic']['server_monitor_agent']['agent_action'] = :install
default['newrelic']['server_monitor_agent']['service_name'] = 'newrelic-sysmond'
default['newrelic']['server_monitor_agent']['service_notify_action'] = :restart
default['newrelic']['server_monitor_agent']['service_actions'] = [:enable, :start] # starts the service if it's not running and enables it to start at system boot time
default['newrelic']['server_monitor_agent']['config_path'] = '/etc/newrelic'
default['newrelic']['server_monitor_agent']['config_file_user'] = 'root'
default['newrelic']['server_monitor_agent']['config_file_group'] = 'newrelic'
default['newrelic']['server_monitor_agent']['windows_version'] = '2.0.0.198'
default['newrelic']['server_monitor_agent']['windows64_checksum'] = '5a8f3f5e8f15997463430401756d377c321c8899c2790ca85e5587a5b643651e'
default['newrelic']['server_monitor_agent']['windows32_checksum'] = 'ac2b65eecaad461fdd2e4386e3e4c9f96ea940b35bdf7a8c532c21dbd1c99ff0'
default['newrelic']['server_monitor_agent']['template']['cookbook'] = 'newrelic'
default['newrelic']['server_monitor_agent']['template']['source'] = 'agent/server_monitor/nrsysmond.cfg.erb'
