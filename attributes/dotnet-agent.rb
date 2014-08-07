#
# Cookbook Name:: newrelic
# Attributes:: dotnet-agent
#
# Copyright 2012-2014, Escape Studios
#

default['newrelic']['agent_type'] = "dotnet"
default['newrelic']['dotnet-agent']['https_download'] = 'https://download.newrelic.com/dot_net_agent/release/x64'
default['newrelic']['dotnet-agent']['install_level'] = '1'
default['newrelic']['dotnet-agent']['dotnet_recipe'] = 'ms_dotnet4'
default['newrelic']['dotnet-agent']['agent_action'] = :install
