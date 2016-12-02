#
# Cookbook Name:: newrelic
# Recipe:: dotnet_agent
#
# Copyright (c) 2016, David Joos
#

newrelic_agent_dotnet 'Install' do
  license NewRelic.application_monitoring_license(node)
end
