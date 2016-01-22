#
# Cookbook Name:: newrelic
# Resource:: agent_ruby
#
# Copyright 2012-2015, Escape Studios
#
actions :install, :remove
default_action :install

attribute :license, :kind_of => String, :default => NewRelic.application_monitoring_license(node)
attribute :agent_type, :kind_of => String, :default => 'ruby'
attribute :install_dir, :kind_of => String, :default => '/opt/newrelic/ruby'
attribute :app_user, :kind_of => String, :default => 'newrelic'
attribute :app_group, :kind_of => String, :default => 'newrelic'
attribute :audit_mode, :kind_of => [TrueClass, FalseClass], :default => false
attribute :template_cookbook, :kind_of => String, :default => 'newrelic'
attribute :template_source, :kind_of => String, :default => 'agent/newrelic.yml.erb'

attribute :enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :app_name, :kind_of => String, :default => nil
attribute :high_security, :kind_of => [TrueClass, FalseClass], :default => false
attribute :owner, :kind_of => String, :default => 'newrelic'
attribute :group, :kind_of => String, :default => 'newrelic'
attribute :logfile, :kind_of => String, :default => 'newrelic-daemon.log'
attribute :logfile_path, :kind_of => String, :default => '/var/log/newrelic/'
attribute :loglevel, :kind_of => String, :default => nil
attribute :audit_mode, :kind_of => [TrueClass, FalseClass], :default => false
attribute :log_file_count, :kind_of => Fixnum, :default => 1
attribute :log_limit_in_kbytes, :kind_of => Fixnum, :default => 0
attribute :log_daily, :kind_of => [TrueClass, FalseClass], :default => true
attribute :daemon_ssl, :kind_of => [TrueClass, FalseClass], :default => true
attribute :daemon_proxy, :kind_of => String, :default => nil
attribute :daemon_proxy_host, :kind_of => String, :default => nil
attribute :daemon_proxy_port, :kind_of => String, :default => nil
attribute :daemon_proxy_user, :kind_of => String, :default => nil
attribute :daemon_proxy_password, :kind_of => String, :default => nil
attribute :capture_params, :kind_of => String, :default => nil
attribute :ignored_params, :kind_of => String, :default => nil
attribute :enable_custom_tracing, :kind_of => [TrueClass, FalseClass], :default => false
attribute :transaction_tracer_enable, :kind_of => [TrueClass, FalseClass], :default => true
attribute :transaction_tracer_threshold, :kind_of => String, :default => nil
attribute :transaction_tracer_record_sql, :kind_of => String, :default => nil
attribute :transaction_tracer_stack_trace_threshold, :kind_of => String, :default => nil
attribute :transaction_tracer_slow_sql, :kind_of => String, :default => nil
attribute :transaction_tracer_explain_threshold, :kind_of => String, :default => nil
attribute :error_collector_enable, :kind_of => [TrueClass, FalseClass], :default => true
attribute :error_collector_ignore_errors, :kind_of => String, :default => nil
attribute :error_collector_ignore_status_codes, :kind_of => String, :default => nil
attribute :browser_monitoring_auto_instrument, :kind_of => String, :default => nil
attribute :cross_application_tracer_enable, :kind_of => [TrueClass, FalseClass], :default => true
attribute :thread_profiler_enable, :kind_of => [TrueClass, FalseClass], :default => true
attribute :labels, :kind_of => String, :default => nil
