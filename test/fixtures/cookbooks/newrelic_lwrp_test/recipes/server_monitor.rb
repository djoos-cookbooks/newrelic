#
# Cookbook Name:: newrelic_lwrp_test
# Recipe:: server_monitor
#
# Copyright (c) 2016, David Joos
#

newrelic_server_monitor 'Install' do
  license node['newrelic']['license']
end

# newrelic_server_remove 'Remove' do
#  action :remove
# end
