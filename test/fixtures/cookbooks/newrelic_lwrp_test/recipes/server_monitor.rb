# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: server_monitor
#
# Copyright 2012-2015, Escape Studios
#

newrelic_server_monitor 'Install' do
  license node['newrelic']['license']
end

# newrelic_server_remove 'Remove' do
#  action :remove
# end
