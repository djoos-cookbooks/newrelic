#
# Cookbook Name:: newrelic
# Recipe:: dotnet_agent
#
# Copyright 2012-2015, Escape Studios
#

include_recipe 'newrelic::repository'

license = NewRelic.application_monitoring_license(node)

package_path = "#{Chef::Config[:file_cache_path]}/NewRelicDotNETAgentx64.msi"

remote_file 'Download New Relic .NET Agent' do
  path package_path
  source node['newrelic']['dotnet_agent']['https_download']
end

windows_package 'Install New Relic .NET Agent' do
  source package_path
  options "/qb NR_LICENSE_KEY=#{license} INSTALLLEVEL=#{node['newrelic']['dotnet_agent']['install_level']}"
  installer_type :msi
  action node['newrelic']['dotnet_agent']['agent_action']
  not_if { File.exist?('C:\\Program Files\\New Relic\\.NET Agent') }
end
