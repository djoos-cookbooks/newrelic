#
# Cookbook Name:: newrelic
# Recipe:: dotnet-agent
#
# Copyright 2012-2013, Escape Studios
#

if !File.exists?("C:/Windows/Microsoft.NET/Framework/v4.0.30319")
	include_recipe "ms_dotnet4"
end

windows_package "Install New Relic .NET Agent" do
    source node['newrelic']['dotnet-agent']['https_download']
    options "/qb NR_LICENSE_KEY=#{node['newrelic']['application_monitoring']['license']} INSTALLLEVEL=#{node['newrelic']['dotnet-agent']['install_level']}"
    installer_type :msi
    action :install
    not_if{File.exists?("C:\\Program Files\\New Relic\\.NET Agent")}
end
