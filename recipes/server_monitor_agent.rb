#
# Cookbook Name:: newrelic
# Recipe:: server_monitor_agent
#
# Copyright 2012-2014, Escape Studios
#

newrelic_server_monitor 'Install' do
  license node['newrelic']['license']
end