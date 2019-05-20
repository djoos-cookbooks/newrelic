#
# Cookbook Name:: newrelic
# Resource:: agent_dotnet
#
# Copyright (c) 2016, David Joos
#

actions :install, :remove
default_action :install

attribute :https_download, :kind_of => String, :default => 'https://download.newrelic.com/dot_net_agent/latest_release/NewRelicDotNetAgent_x64.msi'
attribute :install_level, :kind_of => String, :default => '1'
attribute :config_dir, :kind_of => String, :default => 'C:\ProgramData\New Relic\.NET Agent'
attribute :cookbook, :kind_of => String, :default => 'newrelic'
attribute :source, :kind_of => String, :default => 'agent/dotnet/newrelic.config.erb'

attribute :enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :max_stack_trace_lines, :kind_of => Integer, :default => 80
attribute :timing_precision, :kind_of => String, :default => 'low'

attribute :license, :kind_of => String, :default => lazy { NewRelic.application_monitoring_license(node) }
attribute :daemon_ssl, :kind_of => [TrueClass, FalseClass], :default => true
attribute :svc_send_env_info, :kind_of => [TrueClass, FalseClass], :default => true
attribute :svc_sync_startup, :kind_of => [TrueClass, FalseClass], :default => false
attribute :svc_send_data_on_exit, :kind_of => [TrueClass, FalseClass], :default => false
attribute :svc_send_data_on_exit_threshold, :kind_of => Integer, :default => 60_000
attribute :svc_auto_start, :kind_of => [TrueClass, FalseClass], :default => true

attribute :use_proxy, :kind_of => [TrueClass, FalseClass], :default => false
attribute :proxy_host, :kind_of => String, :default => ''
attribute :proxy_port, :kind_of => Integer, :default => 8080
attribute :proxy_domain, :kind_of => String, :default => ''
attribute :proxy_user, :kind_of => String, :default => ''
attribute :proxy_password, :kind_of => String, :default => ''

attribute :app_log_level, :kind_of => String, :default => 'info'
attribute :audit_log_enabled, :kind_of => [TrueClass, FalseClass], :default => false
attribute :log_to_console, :kind_of => [TrueClass, FalseClass], :default => false
attribute :log_directory, :kind_of => String, :default => 'C:\ProgramData\New Relic\.NET Agent\Logs'
attribute :log_file_name, :kind_of => String, :default => 'newrelic.log'

attribute :app_name, :kind_of => String, :default => 'My Application'
attribute :app_disable_samplers, :kind_of => [TrueClass, FalseClass], :default => false

attribute :instrumentation_applications, :kind_of => Array, :default => []
attribute :instrumentation_log_enable, :kind_of => [TrueClass, FalseClass], :default => false

attribute :attributes_collection_enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :attributes_exclude, :kind_of => Array, :default => []
attribute :attributes_include, :kind_of => Array, :default => []

attribute :app_pools, :kind_of => Array, :default => [] # [{name: '', instrument: true|false}]
attribute :app_pools_instrument_default_behavior, :kind_of => [TrueClass, FalseClass], :default => false

attribute :cross_application_tracer_enabled, :kind_of => [TrueClass, FalseClass], :default => true

attribute :error_collector_enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :ignored_exceptions, :kind_of => Array, :default => [
  'System.IO.FileNotFoundException',
  'System.Threading.ThreadAbortException'
]
attribute :ignored_status_codes, :kind_of => Array, :default => [401, 404]

attribute :high_security_enabled, :kind_of => [TrueClass, FalseClass], :default => false

attribute :tx_events_enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :tx_events_max_samples_per_minute, :kind_of => Integer, :default => 10_000
attribute :tx_events_max_samples_stored, :kind_of => Integer, :default => 10_000
attribute :tx_events_attributes_collection_enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :tx_events_attributes_exclude, :kind_of => Array, :default => []
attribute :tx_events_attributes_include, :kind_of => Array, :default => []

attribute :custom_events_enabled, :kind_of => [TrueClass, FalseClass], :default => true

attribute :labels, :kind_of => String, :default => ''

attribute :browser_monitoring_auto_instrument, :kind_of => [TrueClass, FalseClass], :default => true
attribute :browser_monitoring_req_paths_excluded, :kind_of => Array, :default => []
attribute :browser_monitoring_attributes_collection_enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :browser_monitoring_attributes_exclude, :kind_of => Array, :default => []
attribute :browser_monitoring_attributes_include, :kind_of => Array, :default => []

attribute :slow_queries_enabled, :kind_of => [TrueClass, FalseClass], :default => true

attribute :tx_tracer_enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :tx_tracer_transaction_threshold, :kind_of => String, :default => 'apdex_f'
attribute :tx_tracer_stack_trace_threshold, :kind_of => Integer, :default => 500
attribute :tx_tracer_record_sql, :kind_of => String, :default => 'obfuscated'
attribute :tx_tracer_explain_enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :tx_tracer_explain_threshold, :kind_of => Integer, :default => 500
attribute :tx_tracer_max_segments, :kind_of => Integer, :default => 3_000
attribute :tx_tracer_max_stack_trace, :kind_of => Integer, :default => 30
attribute :tx_tracer_max_explain_plans, :kind_of => Integer, :default => 20
attribute :tx_tracer_attributes_collection_enabled, :kind_of => [TrueClass, FalseClass], :default => true
attribute :tx_tracer_attributes_exclude, :kind_of => Array, :default => []
attribute :tx_tracer_attributes_include, :kind_of => Array, :default => []

attribute :ignored_thread_profiling_methods, :kind_of => Array, :default => [
  'System.Threading.WaitHandle:InternalWaitOne',
  'System.Threading.WaitHandle:WaitAny'
]
