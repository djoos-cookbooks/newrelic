
#
# Cookbook Name:: newrelic
# Resource:: agent_nodejs
#
# Copyright (c) 2016, David Joos
#

actions :install, :remove
default_action :install

attribute :license, :kind_of => String, :required => true, :default => lazy { NewRelic.application_monitoring_license(node) }
attribute :version, :kind_of => String, :default => 'latest'
attribute :app_name, :kind_of => String, :default => 'My Node App'
attribute :app_path, :kind_of => String, :name_attribute => true, :required => true
attribute :cookbook, :kind_of => String, :default => 'newrelic'
attribute :source, :kind_of => String, :default => 'agent/nodejs/newrelic.js.erb'
attribute :enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :app_log_level, :kind_of => String, :default => 'info'
attribute :app_log_filepath, :kind_of => String, :default => nil
attribute :capture_params, :kind_of => String, :default => nil
attribute :ignored_params, :kind_of => String, :default => nil
