
#
# Cookbook Name:: newrelic
# Resource:: agent_nodejs
#
# Copyright 2012-2015, Escape Studios
#

actions :install, :remove
default_action :install

attribute :license, :kind_of => String, :required => true, :default => NewRelic.application_monitoring_license(node)
attribute :version, :kind_of => String, :default => nil
attribute :app_name, :kind_of => String, :default => 'My Node App'
attribute :app_path, :kind_of => String, :name_attribute => true, :required => true
attribute :cookbook, :kind_of => String, :default => 'newrelic'
attribute :source, :kind_of => String, :default => 'agent/nodejs/newrelic.js.erb'
attribute :enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :app_log_level, :kind_of => String, :default => 'info'
attribute :app_log_filepath, :kind_of => String, :default => nil
attribute :capture_params, :kind_of => String, :default => nil
attribute :ignored_params, :kind_of => String, :default => nil
