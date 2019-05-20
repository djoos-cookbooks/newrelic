#
# Cookbook Name:: newrelic
# Resource:: agent_infrastructure
#
# Copyright (c) 2017, David Joos
#

actions :install
default_action :install

attribute :license, :kind_of => String, :default => lazy { NewRelic.application_monitoring_license(node) }
attribute :version, :kind_of => String, :default => nil

attribute :display_name, :kind_of => String, :default => nil
attribute :logfile, :kind_of => String, :default => nil
attribute :verbose, :kind_of => Integer, :default => 0
attribute :proxy, :kind_of => String, :default => nil
attribute :custom_attributes, :kind_of => Hash, :default => {}
attribute :on_host_integrations_enable, :kind_of => [TrueClass, FalseClass], :default => false
attribute :template_cookbook, :kind_of => String, :default => 'newrelic'
attribute :template_source, :kind_of => String, :default => 'agent/infrastructure/newrelic.yml.erb'
attribute :service_actions, :kind_of => Array, :default => %w[enable start]
attribute :windows_version, :kind_of => String, :default => '1.0.703'
attribute :windows_checksum, :kind_of => String, :default => '3c9f98325dc484ee8735f01b913803eaef54f06641348b3dd9f3c0b3cd803ace'
