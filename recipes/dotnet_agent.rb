#
# Cookbook Name:: newrelic
# Recipe:: dotnet_agent
#
# Copyright 2012-2015, Escape Studios
#

newrelic_agent_dotnet 'Install' do
  license NewRelic.application_monitoring_license(node)
end
