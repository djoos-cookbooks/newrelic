#
# Cookbook Name:: newrelic
# Recipe:: dotnet-agent
#
# Copyright 2012-2013, Escape Studios
#

include_recipe node['newrelic']['dotnet_recipe']

windows_package "Install New Relic .NET Agent" do
    source node['newrelic']['https_download']
    options "/qb NR_LICENSE_KEY=#{node['newrelic']['application_monitoring']['license']} INSTALLLEVEL=#{node['newrelic']['install_level']}"
    installer_type :msi
    action :install
    not_if{File.exists?("C:\\Program Files\\New Relic\\.NET Agent")}
end
