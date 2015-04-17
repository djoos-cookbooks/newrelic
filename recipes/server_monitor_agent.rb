#
# Cookbook Name:: newrelic
# Recipe:: server_monitor_agent
#
# Copyright 2012-2015, Escape Studios
#

newrelic_server_monitor 'Install' do
  license NewRelic.server_monitoring_license(node)
  logfile node['newrelic']['server_monitoring']['logfile']
  loglevel node['newrelic']['server_monitoring']['loglevel']
  proxy node['newrelic']['server_monitoring']['proxy']
  ssl NewRelic.to_string_from_boolean(node['newrelic']['server_monitoring']['ssl'])
  ssl_ca_bundle node['newrelic']['server_monitoring']['ssl_ca_bundle']
  ssl_ca_path node['newrelic']['server_monitoring']['ssl_ca_path']
  hostname node['newrelic']['server_monitoring']['hostname']
  labels node['newrelic']['server_monitoring']['labels']
  pidfile node['newrelic']['server_monitoring']['pidfile']
  collector_host node['newrelic']['server_monitoring']['collector_host']
  timeout node['newrelic']['server_monitoring']['timeout']
  config_file_user node['newrelic']['server_monitor_agent']['config_file_user']
  config_file_group node['newrelic']['server_monitor_agent']['config_file_group']
  service_notify_action node['newrelic']['server_monitor_agent']['service_notify_action']
  service_actions node['newrelic']['server_monitor_agent']['service_actions']
  windows_version node['newrelic']['server_monitor_agent']['windows_version']
  windows32_checksum node['newrelic']['server_monitor_agent']['windows32_checksum']
  windows64_checksum node['newrelic']['server_monitor_agent']['windows64_checksum']
  cookbook node['newrelic']['server_monitor_agent']['template']['cookbook']
  source node['newrelic']['server_monitor_agent']['template']['source']
  service_name node['newrelic']['server_monitor_agent']['service_name']
  config_path node['newrelic']['server_monitor_agent']['config_path']
end
