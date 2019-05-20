#
# Cookbook Name:: newrelic
# Recipe:: dotnet_agent
#
# Copyright (c) 2016, David Joos
#

newrelic_agent_dotnet 'Install' do
  https_download node['newrelic']['dotnet_agent']['https_download'] unless node['newrelic']['dotnet_agent']['https_download'].nil?
  install_level node['newrelic']['dotnet_agent']['install_level'] unless node['newrelic']['dotnet_agent']['install_level'].nil?
  license lazy { NewRelic.application_monitoring_license(node) }
end
