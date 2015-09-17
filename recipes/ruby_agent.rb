#
# Cookbook Name:: newrelic
# Recipe:: ruby_agent
#
# Copyright 2012-2015, Escape Studios
#

newrelic_agent_ruby 'Install' do
  license NewRelic.application_monitoring_license(node)
  template_cookbook node['newrelic']['ruby_agent']['template_cookbook'] unless node['newrelic']['ruby_agent']['template_cookbook']
  template_source node['newrelic']['ruby_agent']['template_source'] unless node['newrelic']['ruby_agent']['template_source']
  enabled NewRelic.to_boolean(node['newrelic']['application_monitoring']['enabled']) unless node['newrelic']['application_monitoring']['enabled']
  app_name node['newrelic']['application_monitoring']['app_name'] unless node['newrelic']['application_monitoring']['app_name']
  high_security NewRelic.to_boolean(node['newrelic']['application_monitoring']['high_security']) unless node['newrelic']['application_monitoring']['high_security']
  owner node['newrelic']['ruby_agent']['app_user'] unless node['newrelic']['ruby_agent']['app_user']
  group node['newrelic']['ruby_agent']['app_group'] unless node['newrelic']['ruby_agent']['app_group']
  logfile node['newrelic']['application_monitoring']['logfile'] unless node['newrelic']['application_monitoring']['logfile']
  logfile_path node['newrelic']['application_monitoring']['logfile_path'] unless node['newrelic']['application_monitoring']['logfile_path']
  loglevel node['newrelic']['application_monitoring']['loglevel'] unless node['newrelic']['application_monitoring']['loglevel']
  audit_mode node['newrelic']['ruby_agent']['audit_mode'] unless node['newrelic']['ruby_agent']['audit_mode']
  log_file_count node['newrelic']['ruby_agent']['log_file_count'] unless node['newrelic']['ruby_agent']['log_file_count']
  log_limit_in_kbytes node['newrelic']['ruby_agent']['log_limit_in_kbytes'] unless node['newrelic']['ruby_agent']['log_limit_in_kbytes']
  log_daily node['newrelic']['ruby_agent']['log_daily'] unless node['newrelic']['ruby_agent']['log_daily']
  daemon_ssl NewRelic.to_boolean(node['newrelic']['application_monitoring']['daemon']['ssl']) unless node['newrelic']['application_monitoring']['daemon']['ssl']
  daemon_proxy node['newrelic']['application_monitoring']['daemon']['proxy'] unless node['newrelic']['application_monitoring']['daemon']['proxy']
  capture_params node['newrelic']['application_monitoring']['capture_params'] unless node['newrelic']['application_monitoring']['capture_params']
  ignored_params node['newrelic']['application_monitoring']['ignored_params'] unless node['newrelic']['application_monitoring']['ignored_params']
  transaction_tracer_enable node['newrelic']['application_monitoring']['transaction_tracer']['enable'] unless node['newrelic']['application_monitoring']['transaction_tracer']['enable']
  transaction_tracer_threshold node['newrelic']['application_monitoring']['transaction_tracer']['threshold'] unless node['newrelic']['application_monitoring']['transaction_tracer']['threshold']
  transaction_tracer_record_sql node['newrelic']['application_monitoring']['transaction_tracer']['record_sql'] unless node['newrelic']['application_monitoring']['transaction_tracer']['record_sql']
  transaction_tracer_stack_trace_threshold node['newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold'] unless node['newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold']
  transaction_tracer_slow_sql node['newrelic']['application_monitoring']['transaction_tracer']['slow_sql'] unless node['newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold']
  transaction_tracer_explain_threshold node['newrelic']['application_monitoring']['transaction_tracer']['explain_threshold'] unless node['newrelic']['application_monitoring']['transaction_tracer']['explain_threshold']
  error_collector_enable NewRelic.to_boolean(node['newrelic']['application_monitoring']['error_collector']['enable']) unless node['newrelic']['application_monitoring']['error_collector']['enable']
  error_collector_ignore_errors node['newrelic']['application_monitoring']['error_collector']['ignore_errors'] unless node['newrelic']['application_monitoring']['error_collector']['ignore_errors']
  error_collector_ignore_status_codes node['newrelic']['application_monitoring']['error_collector']['ignore_status_codes'] unless node['newrelic']['application_monitoring']['error_collector']['ignore_status_codes']
  browser_monitoring_auto_instrument node['newrelic']['application_monitoring']['browser_monitoring']['auto_instrument'] unless node['newrelic']['application_monitoring']['browser_monitoring']['auto_instrument']
  cross_application_tracer_enable NewRelic.to_boolean(node['newrelic']['application_monitoring']['cross_application_tracer']['enable']) unless node['newrelic']['application_monitoring']['cross_application_tracer']['enable']
  thread_profiler_enable NewRelic.to_boolean(node['newrelic']['application_monitoring']['thread_profiler']['enable']) unless node['newrelic']['application_monitoring']['thread_profiler']['enable']
  labels node['newrelic']['application_monitoring']['labels'] unless node['newrelic']['application_monitoring']['labels'].nil?
end
