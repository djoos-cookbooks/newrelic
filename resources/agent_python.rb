#
# Cookbook Name:: newrelic
# Resource:: agent_python
#
# Copyright 2012-2015, Escape Studios
#

actions :install, :remove
default_action :install

attribute :license, :kind_of => String, :required => true, :default => NewRelic.application_monitoring_license(node)
attribute :version, :kind_of => String, :default => nil
attribute :virtualenv, :kind_of => String, :default => nil
attribute :config_file, :kind_of => String, :default => '/etc/newrelic/newrelic.ini'
attribute :cookbook, :kind_of => String, :default => 'newrelic'
attribute :source, :kind_of => String, :default => 'agent/python/newrelic.ini.erb'
attribute :app_name, :kind_of => String, :default => 'Python Application'
attribute :enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :logfile, :kind_of => String, :default => '/tmp/newrelic-python-agent.log'
attribute :loglevel, :kind_of => String, :default => 'info'
attribute :daemon_ssl, :kind_of => [TrueClass, FalseClass], :default => true
attribute :high_security, :kind_of => [TrueClass, FalseClass], :default => false
attribute :capture_params, :kind_of => [TrueClass, FalseClass], :default => false
attribute :ignored_params, :kind_of => String, :default => ' '
attribute :transaction_tracer_enable, :kind_of => [TrueClass, FalseClass], :default => true
attribute :transaction_tracer_threshold, :kind_of => String, :default => 'apdex_f'
attribute :transaction_tracer_record_sql, :kind_of => String, :default => 'obfuscated'
attribute :transaction_tracer_stack_trace_threshold, :kind_of => String, :default => '0.5'
attribute :transaction_tracer_slow_sql, :kind_of => [TrueClass, FalseClass], :default => true
attribute :transaction_tracer_explain_threshold, :kind_of => String, :default => '0.5'
attribute :thread_profiler_enable, :kind_of => [TrueClass, FalseClass], :default => true
attribute :error_collector_enable, :kind_of => [TrueClass, FalseClass], :default => true
attribute :error_collector_ignore_errors, :kind_of => String, :default => ' '
attribute :browser_monitoring_auto_instrument, :kind_of => [TrueClass, FalseClass], :default => true
attribute :cross_application_tracer_enable, :kind_of => [TrueClass, FalseClass], :default => true
attribute :feature_flag, :kind_of => String, :default => nil
