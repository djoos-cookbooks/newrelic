#
# Cookbook Name:: newrelic
# Recipe:: dotnet_agent
#
#
#

newrelic_agent_dotnetcore 'Install' do
  https_download node['newrelic']['dotnetcore_agent']['https_download'] unless node['newrelic']['dotnetcore_agent']['https_download'].nil?
  # install_level node['newrelic']['dotnet_agent']['install_level'] unless node['newrelic']['dotnet_agent']['install_level'].nil?
  license lazy { NewRelic.application_monitoring_license(node) }
end
