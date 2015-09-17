#
# Cookbook Name:: newrelic
# Resource:: agent_dotnet
#
# Copyright 2012-2015, Escape Studios
#

actions :install, :remove
default_action :install

attribute :license, :kind_of => String, :default => NewRelic.application_monitoring_license(node)
attribute :https_download, :kind_of => String, :default => 'https://download.newrelic.com/dot_net_agent/release/x64'
attribute :install_level, :kind_of => String, :default => '1'
