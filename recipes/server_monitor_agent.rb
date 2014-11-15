#
# Cookbook Name:: newrelic
# Recipe:: server_monitor_agent
#
# Copyright 2012-2014, Escape Studios
#

include_recipe 'newrelic::repository'

license = NewRelic.server_monitoring_license(node)

case node['platform']
when 'debian', 'ubuntu', 'redhat', 'centos', 'fedora', 'scientific', 'amazon', 'smartos'
  package node['newrelic']['server_monitor_agent']['service_name'] do
    action node['newrelic']['server_monitor_agent']['agent_action']
  end

  # configure your New Relic license key
  template "#{node['newrelic']['server_monitor_agent']['config_path']}/nrsysmond.cfg" do
    cookbook node['newrelic']['server_monitor_agent']['template']['cookbook']
    source node['newrelic']['server_monitor_agent']['template']['source']
    owner node['newrelic']['server_monitor_agent']['config_file_user']
    group node['newrelic']['server_monitor_agent']['config_file_group']
    mode 0640
    variables(
      :license => license,
      :logfile => node['newrelic']['server_monitoring']['logfile'],
      :loglevel => node['newrelic']['server_monitoring']['loglevel'],
      :proxy => node['newrelic']['server_monitoring']['proxy'],
      :ssl => node['newrelic']['server_monitoring']['ssl'],
      :ssl_ca_bundle => node['newrelic']['server_monitoring']['ssl_ca_bundle'],
      :ssl_ca_path => node['newrelic']['server_monitoring']['ssl_ca_path'],
      :hostname => node['newrelic']['server_monitoring']['hostname'],
      :pidfile => node['newrelic']['server_monitoring']['pidfile'],
      :collector_host => node['newrelic']['server_monitoring']['collector_host'],
      :timeout => node['newrelic']['server_monitoring']['timeout']
    )
    notifies node['newrelic']['server_monitor_agent']['service_notify_action'], "service[#{node['newrelic']['server_monitor_agent']['service_name']}]"
  end

  service node['newrelic']['server_monitor_agent']['service_name'] do
    supports :status => true, :start => true, :stop => true, :restart => true
    action node['newrelic']['server_monitor_agent']['service_actions']
  end
when 'windows'
  if node['kernel']['machine'] == 'x86_64'
    windows_package 'New Relic Server Monitor' do
      source "http://download.newrelic.com/windows_server_monitor/release/NewRelicServerMonitor_x64_#{node['newrelic']['server_monitor_agent']['windows_version']}.msi"
      options "/L*v install.log /qn NR_LICENSE_KEY=#{license}"
      action node['newrelic']['server_monitor_agent']['agent_action']
      version node['newrelic']['server_monitor_agent']['windows_version']
      checksum node['newrelic']['server_monitor_agent']['windows64_checksum']
    end
  else
    windows_package 'New Relic Server Monitor' do
      source "http://download.newrelic.com/windows_server_monitor/release/NewRelicServerMonitor_x86_#{node['newrelic']['server_monitor_agent']['windows_version']}.msi"
      options "/L*v install.log /qn NR_LICENSE_KEY=#{license}"
      action node['newrelic']['server_monitor_agent']['agent_action']
      version node['newrelic']['server_monitor_agent']['windows_version']
      checksum node['newrelic']['server_monitor_agent']['windows32_checksum']
    end
  end

  # on Windows service creation/startup is done by the installer
end
