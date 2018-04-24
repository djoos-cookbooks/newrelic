#
# Cookbook Name:: newrelic_lwrp_test
# Recipe:: agent_dotnet
#
# Copyright (c) 2016, David Joos
#

newrelic_agent_dotnet 'Install' do
  license node['newrelic']['license']
  app_name 'My Application;Sub Application'
end
