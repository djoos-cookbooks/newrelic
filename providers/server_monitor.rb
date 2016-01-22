#
# Cookbook Name:: newrelic
# Provider:: server_monitor
#
# Copyright 2012-2015, Escape Studios
#

# include helper methods
include NewRelic::Helpers
include NewRelic::ServerMonitorHelpers

use_inline_resources if defined?(use_inline_resources)

action :install do
  check_license
  newrelic_repository
  case node['platform_family']
  when 'debian', 'rhel', 'fedora'
    install_newrelic_service_linux
  when 'windows'
    install_newrelic_service_windows
  end
end

action :remove do
  case node['platform_family']
  when 'debian', 'rhel', 'fedora'
    remove_newrelic_service_linux
  when 'windows'
    remove_newrelic_service_windows
  end
end

def install_newrelic_service_linux
  package new_resource.service_name do
    action new_resource.action
  end
  # configure your New Relic license key
  template "#{new_resource.config_path}/nrsysmond.cfg" do
    cookbook new_resource.cookbook
    source new_resource.source
    owner new_resource.config_file_user
    group new_resource.config_file_group
    mode 0640
    variables(
      :resource => new_resource
    )
    sensitive true
    notifies new_resource.service_notify_action, "service[#{new_resource.service_name}]"
  end
  service new_resource.service_name do
    supports :status => true, :start => true, :stop => true, :restart => true, :enable => true
    action new_resource.service_actions
  end

  update_newrelic_alert_policy_linux(new_resource.alert_policy_id) if new_resource.alert_policy_id
end

def install_newrelic_service_windows
  if node['kernel']['machine'] == 'x86_64'
    windows_package 'New Relic Server Monitor' do
      source "http://download.newrelic.com/windows_server_monitor/release/NewRelicServerMonitor_x64_#{new_resource.windows_version}.msi"
      options "/L*v install.log /qn NR_LICENSE_KEY=#{new_resource.license}"
      action new_resource.action
      version new_resource.windows_version
      checksum new_resource.windows64_checksum
    end
  else
    windows_package 'New Relic Server Monitor' do
      source "http://download.newrelic.com/windows_server_monitor/release/NewRelicServerMonitor_x86_#{new_resource.windows_version}.msi"
      options "/L*v install.log /qn NR_LICENSE_KEY=#{new_resource.license}"
      action new_resource.action
      version new_resource.windows_version
      checksum new_resource.windows32_checksum
    end
  end
  # on Windows service creation/startup is done by the installer
end

def remove_newrelic_service_linux
  update_newrelic_alert_policy_linux(new_resource.alert_policy_id) if new_resource.alert_policy_id

  package new_resource.service_name do
    action new_resource.action
  end
end

def remove_newrelic_service_windows
  windows_package 'New Relic Server Monitor' do
    action new_resource.action
  end
end

def update_newrelic_alert_policy_linux(alert_policy_id)
  ruby_block 'Move server to newrelic decommissioned policy' do
    block do
      update_alert_policy(alert_policy_id)
    end

    only_if do
      node['newrelic']['api_key'].length > 0
    end
  end
end
