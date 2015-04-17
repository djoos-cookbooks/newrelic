#
# Cookbook Name:: newrelic
# Recipe:: server_monitor_agent
#
# Copyright 2012-2015, Escape Studios
#

newrelic_server_monitor 'Install' do
  license NewRelic.server_monitoring_license(node)
  logfile node['newrelic']['server_monitoring']['logfile'] if node['newrelic']['server_monitoring']['logfile']
  loglevel node['newrelic']['server_monitoring']['loglevel'] if node['newrelic']['server_monitoring']['loglevel']
  proxy node['newrelic']['server_monitoring']['proxy'] if node['newrelic']['server_monitoring']['proxy']
  ssl node['newrelic']['server_monitoring']['ssl'] if node['newrelic']['server_monitoring']['ssl']
  ssl_ca_bundle node['newrelic']['server_monitoring']['ssl_ca_bundle'] if node['newrelic']['server_monitoring']['ssl_ca_bundle']
  ssl_ca_path node['newrelic']['server_monitoring']['ssl_ca_path'] if node['newrelic']['server_monitoring']['ssl_ca_path']
  hostname node['newrelic']['server_monitoring']['hostname'] if node['newrelic']['server_monitoring']['hostname']
  labels node['newrelic']['server_monitoring']['labels'] if node['newrelic']['server_monitoring']['labels']
  pidfile node['newrelic']['server_monitoring']['pidfile'] if node['newrelic']['server_monitoring']['pidfile']
  collector_host node['newrelic']['server_monitoring']['collector_host'] if node['newrelic']['server_monitoring']['collector_host']
  timeout node['newrelic']['server_monitoring']['timeout'] if node['newrelic']['server_monitoring']['timeout']
  config_file_user node['newrelic']['server_monitor_agent']['config_file_user'] if node['newrelic']['server_monitor_agent']['config_file_user']
  config_file_group node['newrelic']['server_monitor_agent']['config_file_group'] if node['newrelic']['server_monitor_agent']['config_file_group']
  service_notify_action node['newrelic']['server_monitor_agent']['service_notify_action'] if node['newrelic']['server_monitor_agent']['service_notify_action']
  service_actions node['newrelic']['server_monitor_agent']['service_actions'] if node['newrelic']['server_monitor_agent']['service_actions']
  windows_version node['newrelic']['server_monitor_agent']['windows_version'] if node['newrelic']['server_monitor_agent']['windows_version']
  windows32_checksum node['newrelic']['server_monitor_agent']['windows32_checksum'] if node['newrelic']['server_monitor_agent']['windows32_checksum']
  windows64_checksum node['newrelic']['server_monitor_agent']['windows64_checksum'] if node['newrelic']['server_monitor_agent']['windows64_checksum']
  cookbook node['newrelic']['server_monitor_agent']['template']['cookbook'] if node['newrelic']['server_monitor_agent']['template']['cookbook']
  source node['newrelic']['server_monitor_agent']['template']['source'] if node['newrelic']['server_monitor_agent']['template']['source']
  service_name node['newrelic']['server_monitor_agent']['service_name'] if node['newrelic']['server_monitor_agent']['service_name']
  config_path node['newrelic']['server_monitor_agent']['config_path'] if node['newrelic']['server_monitor_agent']['config_path']
end
