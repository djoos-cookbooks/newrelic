#
# Cookbook Name:: newrelic
# Recipe:: java_agent
#
# Copyright 2012-2015, Escape Studios
#

newrelic_agent_java 'Install' do
  license NewRelic.application_monitoring_license(node)
  version node['newrelic']['java_agent']['version'] unless node['newrelic']['java_agent']['version'].nil?
  install_dir node['newrelic']['java_agent']['install_dir'] unless node['newrelic']['java_agent']['install_dir'].nil?
  app_location node['newrelic']['java_agent']['app_location'] unless node['newrelic']['java_agent']['app_location'].nil?
  template_cookbook node['newrelic']['java_agent']['template_cookbook'] unless node['newrelic']['java_agent']['template_cookbook'].nil?
  template_source node['newrelic']['java_agent']['template_source'] unless node['newrelic']['java_agent']['template_source'].nil?
  enable_custom_tracing node['newrelic']['java_agent']['enable_custom_tracing'] unless node['newrelic']['java_agent']['enable_custom_tracing'].nil?
  enabled node['newrelic']['application_monitoring']['enabled'] unless node['newrelic']['application_monitoring']['enabled'].nil?
  app_name node['newrelic']['application_monitoring']['app_name'] unless node['newrelic']['application_monitoring']['app_name'].nil?
  high_security NewRelic.to_boolean(node['newrelic']['application_monitoring']['high_security']) unless node['newrelic']['application_monitoring']['high_security'].nil?
  app_user node['newrelic']['java_agent']['app_user'] unless node['newrelic']['java_agent']['app_user'].nil?
  app_group node['newrelic']['java_agent']['app_group'] unless node['newrelic']['java_agent']['app_group'].nil?
  logfile node['newrelic']['application_monitoring']['logfile'] unless node['newrelic']['application_monitoring']['logfile'].nil?
  logfile_path node['newrelic']['application_monitoring']['logfile_path'] unless node['newrelic']['application_monitoring']['logfile_path'].nil?
  loglevel node['newrelic']['application_monitoring']['loglevel'] unless node['newrelic']['application_monitoring']['loglevel'].nil?
  audit_mode node['newrelic']['java_agent']['audit_mode'] unless node['newrelic']['java_agent']['audit_mode'].nil?
  log_file_count node['newrelic']['java_agent']['log_file_count'] unless node['newrelic']['java_agent']['log_file_count'].nil?
  log_limit_in_kbytes node['newrelic']['java_agent']['log_limit_in_kbytes'] unless node['newrelic']['java_agent']['log_limit_in_kbytes'].nil?
  log_daily node['newrelic']['java_agent']['log_daily'] unless node['newrelic']['java_agent']['log_daily'].nil?
  daemon_ssl NewRelic.to_boolean(node['newrelic']['application_monitoring']['daemon']['ssl']) unless node['newrelic']['application_monitoring']['daemon']['ssl'].nil?
  daemon_proxy node['newrelic']['application_monitoring']['daemon']['proxy'] unless node['newrelic']['application_monitoring']['daemon']['proxy'].nil?
  daemon_proxy_host node['newrelic']['application_monitoring']['daemon']['proxy_host'] unless node['newrelic']['application_monitoring']['daemon']['proxy_host'].nil?
  daemon_proxy_port node['newrelic']['application_monitoring']['daemon']['proxy_port'] unless node['newrelic']['application_monitoring']['daemon']['proxy_port'].nil?
  daemon_proxy_user node['newrelic']['application_monitoring']['daemon']['proxy_user'] unless node['newrelic']['application_monitoring']['daemon']['proxy_user'].nil?
  daemon_proxy_password node['newrelic']['application_monitoring']['daemon']['proxy_password'] unless node['newrelic']['application_monitoring']['daemon']['proxy_password'].nil?
  capture_params node['newrelic']['application_monitoring']['capture_params'] unless node['newrelic']['application_monitoring']['capture_params'].nil?
  ignored_params node['newrelic']['application_monitoring']['ignored_params'] unless node['newrelic']['application_monitoring']['ignored_params'].nil?
  transaction_tracer_enable node['newrelic']['application_monitoring']['transaction_tracer']['enable'] unless node['newrelic']['application_monitoring']['transaction_tracer']['enable'].nil?
  transaction_tracer_threshold node['newrelic']['application_monitoring']['transaction_tracer']['threshold'] unless node['newrelic']['application_monitoring']['transaction_tracer']['threshold'].nil?
  transaction_tracer_record_sql node['newrelic']['application_monitoring']['transaction_tracer']['record_sql'] unless node['newrelic']['application_monitoring']['transaction_tracer']['record_sql'].nil?
  transaction_tracer_stack_trace_threshold node['newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold'] unless node['newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold'].nil?
  transaction_tracer_slow_sql node['newrelic']['application_monitoring']['transaction_tracer']['slow_sql'] unless node['newrelic']['application_monitoring']['transaction_tracer']['slow_sql'].nil?
  transaction_tracer_explain_threshold node['newrelic']['application_monitoring']['transaction_tracer']['explain_threshold'] unless node['newrelic']['application_monitoring']['transaction_tracer']['explain_threshold'].nil?
  error_collector_enable NewRelic.to_boolean(node['newrelic']['application_monitoring']['error_collector']['enable']) unless node['newrelic']['application_monitoring']['error_collector']['enable'].nil?
  error_collector_ignore_errors node['newrelic']['application_monitoring']['error_collector']['ignore_errors'] unless node['newrelic']['application_monitoring']['error_collector']['ignore_errors'].nil?
  error_collector_ignore_status_codes node['newrelic']['application_monitoring']['error_collector']['ignore_status_codes'] unless node['newrelic']['application_monitoring']['error_collector']['ignore_status_codes'].nil?
  browser_monitoring_auto_instrument node['newrelic']['application_monitoring']['browser_monitoring']['auto_instrument'] unless node['newrelic']['application_monitoring']['browser_monitoring']['auto_instrument'].nil?
  cross_application_tracer_enable NewRelic.to_boolean(node['newrelic']['application_monitoring']['cross_application_tracer']['enable']) unless node['newrelic']['application_monitoring']['cross_application_tracer']['enable'].nil?
  thread_profiler_enable NewRelic.to_boolean(node['newrelic']['application_monitoring']['thread_profiler']['enable']) unless node['newrelic']['application_monitoring']['thread_profiler']['enable'].nil?
  labels node['newrelic']['application_monitoring']['labels'] unless node['newrelic']['application_monitoring']['labels'].nil?
  execute_agent_action node['newrelic']['java_agent']['execute_agent_action'] unless node['newrelic']['java_agent']['execute_agent_action'].nil?
end
