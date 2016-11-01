#
# Cookbook Name:: newrelic
# Recipe:: agent_dotnet
#
# Copyright (c) 2016, David Joos
#

# include helper methods
include NewRelic::Helpers

use_inline_resources if defined?(use_inline_resources)

action :install do
  check_license
  install_newrelic
end

action :remove do
  remove_newrelic
end

def install_newrelic
  windows_package 'Install New Relic .NET Agent' do
    source new_resource.https_download
    options "/qb NR_LICENSE_KEY=#{new_resource.license} INSTALLLEVEL=#{new_resource.install_level}"
    installer_type :msi
    action :install
    not_if { ::File.exist?('C:\\Program Files\\New Relic\\.NET Agent') }
  end

  template "#{new_resource.config_dir}/newrelic.config" do
    cookbook new_resource.cookbook
    source new_resource.source
    variables(
      :resource => new_resource
    )
    sensitive true
  end
end

def remove_newrelic
  windows_package 'Remove New Relic .NET Agent' do
    source new_resource.https_download
    action :remove
  end
end
