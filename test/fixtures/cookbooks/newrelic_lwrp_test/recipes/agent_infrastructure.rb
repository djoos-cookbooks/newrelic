#
# Cookbook Name:: newrelic_lwrp_test
# Recipe:: agent_infrastructure
#
# Copyright (c) 2017, David Joos
#

newrelic_agent_infrastructure 'Install' do
  on_host_integrations_enable true
end
