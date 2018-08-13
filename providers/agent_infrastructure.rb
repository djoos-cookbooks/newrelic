#
# Cookbook Name:: newrelic
# Provider:: agent_infrastructure
#
# Copyright (c) 2017, David Joos
#

# include helper methods
include NewRelic::Helpers

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :install do
  check_license
  newrelic_repository_infrastructure
  case node['platform_family']
  when 'debian', 'rhel', 'amazon'
    install_newrelic_infrastructure_service_linux
  when 'windows'
    install_newrelic_infrastructure_service_windows
  end
end

def install_newrelic_infrastructure_service_linux
  # lay down newrelic-infra agent config
  template '/etc/newrelic-infra.yml' do
    cookbook new_resource.template_cookbook
    source new_resource.template_source
    owner 'root'
    group 'root'
    mode '0600'
    variables(
      :resource => new_resource
    )
    sensitive true
    notifies :restart, 'service[newrelic-infra]', :delayed
  end

  # install the newrelic infrastructure agent
  package 'newrelic-infra' do
    action new_resource.action
    version new_resource.version unless new_resource.version.nil?
  end

  # install the newrelic infrastructure on-host integration
  if new_resource.on_host_integrations_enable
    package 'newrelic-infra-integrations' do
      action new_resource.action
    end
  end

  service_provider = linux_service_provider

  # setup newrelic infrastructure service
  service 'newrelic-infra' do
    provider service_provider unless service_provider.nil?
    action new_resource.service_actions
  end
end

# rubocop:disable Metrics/CyclomaticComplexity
def linux_service_provider
  service_provider = Chef::Provider::Service::Systemd

  # upstart workaround(s)
  case node['platform_family']
  when 'amazon'
    if node['platform_version'].to_i == 1
      service_provider = Chef::Provider::Service::Upstart
    end
  when 'rhel'
    if node['platform_version'] =~ /^6/
      service_provider = Chef::Provider::Service::Upstart
    end
  when 'ubuntu'
    if node['platform_version'].to_f < 16.04
      service_provider = Chef::Provider::Service::Upstart
    end
  end

  service_provider
end

def install_newrelic_infrastructure_service_windows
  windows_package 'newrelic-infra' do
    source "https://download.newrelic.com/infrastructure_agent/windows/newrelic-infra.#{new_resource.windows_version}.msi"
    installer_type :msi
    version new_resource.windows_version
    action new_resource.action
    checksum new_resource.windows_checksum
  end

  # lay down newrelic-infra agent config
  template 'C:\Program Files\New Relic\newrelic-infra\newrelic-infra.yml' do
    cookbook new_resource.template_cookbook
    source new_resource.template_source
    variables(
      :resource => new_resource
    )
    sensitive true
    notifies :restart, 'service[newrelic-infra]', :delayed
  end

  # setup newrelic-infra service
  service 'newrelic-infra' do
    action new_resource.service_actions
  end
end
