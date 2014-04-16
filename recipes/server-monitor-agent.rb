#
# Cookbook Name:: newrelic
# Recipe:: server-monitor-agent
#
# Copyright 2012-2014, Escape Studios
#

include_recipe 'newrelic::repository'

license = node['newrelic']['server_monitoring']['license']

case node['platform']
when 'debian', 'ubuntu', 'redhat', 'centos', 'fedora', 'scientific', 'amazon', 'smartos'
  package node['newrelic']['server-monitor-agent']['service_name'] do
    action :install
  end

  # configure your New Relic license key
  template "#{node['newrelic']['server-monitor-agent']['config_path']}/nrsysmond.cfg" do
    source 'agent/server-monitor/nrsysmond.cfg.erb'
    owner 'root'
    group node['newrelic']['server-monitor-agent']['config_file_group']
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
    notifies node['newrelic']['server-monitor-agent']['service_notify_action'], "service[#{node['newrelic']['server-monitor-agent']['service_name']}]"
  end

  service node['newrelic']['server-monitor-agent']['service_name'] do
    supports :status => true, :start => true, :stop => true, :restart => true
    action node['newrelic']['server-monitor-agent']['service_actions']
  end
when 'windows'
  include_recipe node['newrelic']['dotnet-agent']['dotnet_recipe']

  if node['kernel']['machine'] == 'x86_64'
    windows_package 'New Relic Server Monitor' do
      source "http://download.newrelic.com/windows_server_monitor/release/NewRelicServerMonitor_x64_#{node['newrelic']['server-monitor-agent']['windows_version']}.msi"
      options "/L*v install.log /qn NR_LICENSE_KEY=#{license}"
      action :install
      version node['newrelic']['server-monitor-agent']['windows_version']
      checksum node['newrelic']['server-monitor-agent']['windows64_checksum']
    end
  else
    windows_package 'New Relic Server Monitor' do
      source "http://download.newrelic.com/windows_server_monitor/release/NewRelicServerMonitor_x86_#{node['newrelic']['server-monitor-agent']['windows_version']}.msi"
      options "/L*v install.log /qn NR_LICENSE_KEY=#{license}"
      action :install
      version node['newrelic']['server-monitor-agent']['windows_version']
      checksum node['newrelic']['server-monitor-agent']['windows32_checksum']
    end
  end

  # on Windows service creation/startup is done by the installer
end
