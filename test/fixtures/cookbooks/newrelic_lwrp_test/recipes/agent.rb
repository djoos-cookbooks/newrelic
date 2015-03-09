# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: agent
#
# Copyright 2015, Rackspace
#

newrelic_agent 'Install' do
  license node['newrelic']['license']
end

# newrelic_agent 'Remove' do
#  action :remove
# end
