#
# Cookbook Name:: newrelic
# Recipe:: default
#
# Copyright (c) 2016, David Joos
#

# Deprecated July 2018 when NEw RElic shut down the Server Monitor listener
# infavor of the infrastructure agent

include_recipe 'newrelic::server_monitor_agent'
