#
# Cookbook Name:: newrelic
# Attributes:: dotnet-agent
#
# Copyright 2012-2014, Escape Studios
#

default['newrelic']['https_download'] = "https://download.newrelic.com/dot_net_agent/release/x64"
default['newrelic']['install_level'] = "1"
default['newrelic']['dotnet_recipe'] = "ms_dotnet4"