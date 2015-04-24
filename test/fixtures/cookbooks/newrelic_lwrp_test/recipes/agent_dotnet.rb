# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: agent_dotnet
#
# Copyright 2015, Rackspace
#

newrelic_agent_dotnet 'Install' do
  license node['newrelic']['license']
end
