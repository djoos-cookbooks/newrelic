#
# Cookbook Name:: newrelic
# Provider:: yml
#
# Copyright 2012-2014, Escape Studios
#

action :generate do
  t = template new_resource.yml_path do
    cookbook 'newrelic'
    source 'agent/newrelic.yml.erb'
    owner new_resource.owner
    group new_resource.group
    mode 0644
    variables(
      :agent_type => new_resource.agent_type,
      :enabled => new_resource.enabled,
      :license => new_resource.license,
      :app_name => new_resource.app_name,
      :logfile => new_resource.logfile,
      :logfile_path => new_resource.logfile_path,
      :loglevel => new_resource.loglevel,
      :audit_mode => new_resource.audit_mode,
      :log_file_count => new_resource.log_file_count,
      :log_limit_in_kbytes => new_resource.log_limit_in_kbytes,
      :log_daily => new_resource.log_daily,
      :daemon_ssl => new_resource.daemon_ssl,
      :capture_params => new_resource.capture_params,
      :ignored_params => new_resource.ignored_params,
      :transaction_tracer_enable => new_resource.transaction_tracer_enable,
      :transaction_tracer_threshold => new_resource.transaction_tracer_threshold,
      :transaction_tracer_record_sql => new_resource.transaction_tracer_record_sql,
      :transaction_tracer_stack_trace_threshold => new_resource.transaction_tracer_stack_trace_threshold,
      :transaction_tracer_slow_sql => new_resource.transaction_tracer_slow_sql,
      :transaction_tracer_explain_threshold => new_resource.transaction_tracer_explain_threshold,
      :error_collector_enable => new_resource.error_collector_enable,
      :error_collector_ignore_errors => new_resource.error_collector_ignore_errors,
      :browser_monitoring_auto_instrument => new_resource.browser_monitoring_auto_instrument,
      :cross_application_tracer_enable => new_resource.cross_application_tracer_enable
    )
    action :create
  end

  new_resource.updated_by_last_action(t.updated_by_last_action?)
end
