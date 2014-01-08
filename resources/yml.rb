#
# Cookbook Name:: newrelic
# Resource:: yml 
#
# Simplify management of the newrelic.yml config file
#

actions :activate
default_action :activate

attribute :yml_path, :kind_of => String, :name_attribute => true

attribute :app_name, :kind_of => String, :default => nil 
attribute :agent_type, :kind_of => String,  :required => true, :regex => /^(java|ruby|nodejs|dotnet)$/
attribute :owner, :kind_of => String, :default => node['newrelic']['app_user'] 
attribute :group, :kind_of => String, :default => node['newrelic']['app_group'] 

attribute :license, :kind_of => String, :default => node['newrelic']['application_monitoring']['license']
attribute :logfile, :kind_of => String, :default => node['newrelic']['application_monitoring']['logfile']
attribute :loglevel, :kind_of => String, :default => node['newrelic']['application_monitoring']['loglevel']
attribute :audit_mode, :kind_of => [TrueClass, FalseClass, String], :default => node['newrelic']['audit_mode']
attribute :log_file_count,  :default => node['newrelic']['log_file_count']
attribute :log_limit_in_kbytes,  :default => node['newrelic']['log_limit_in_kbytes']
attribute :log_daily,  :default => node['newrelic']['log_daily']
attribute :daemon_ssl, :default => node['newrelic']['application_monitoring']['daemon']['ssl']
attribute :capture_params, :default => node['newrelic']['application_monitoring']['capture_params']
attribute :ignored_params, :default => node['newrelic']['application_monitoring']['ignored_params']
attribute :transaction_tracer_enable,  :default => node['newrelic']['application_monitoring']['transaction_tracer']['enable']
attribute :transaction_tracer_threshold, :default => node['newrelic']['application_monitoring']['transaction_tracer']['threshold']
attribute :transaction_tracer_record_sql,  :default => node['newrelic']['application_monitoring']['transaction_tracer']['record_sql']
attribute :transaction_tracer_stack_trace_threshold,  :default => node['newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold']
attribute :transaction_tracer_slow_sql,  :default => node['newrelic']['application_monitoring']['transaction_tracer']['slow_sql']
attribute :transaction_tracer_explain_threshold,  :default => node['newrelic']['application_monitoring']['transaction_tracer']['explain_threshold']
attribute :error_collector_enable,  :default => node['newrelic']['application_monitoring']['error_collector']['enable']
attribute :browser_monitoring_auto_instrument,  :default => node['newrelic']['application_monitoring']['browser_monitoring']['auto_instrument']

