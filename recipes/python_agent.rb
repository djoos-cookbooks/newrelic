#
# Cookbook Name:: newrelic
# Recipe:: python_agent
#
# Copyright 2012-2015, Escape Studios
#

newrelic_agent_python 'new python agent' do
  license NewRelic.application_monitoring_license(node)
  config_file node['newrelic']['python_agent']['config_file'] unless node['newrelic']['python_agent']['config_file'].nil?
  cookbook node['newrelic']['python_agent']['template']['cookbook'] unless node['newrelic']['python_agent']['template']['cookbook'].nil?
  source node['newrelic']['python_agent']['template']['source'] unless node['newrelic']['python_agent']['template']['source'].nil?
  app_name node['newrelic']['application_monitoring']['app_name'] unless node['newrelic']['application_monitoring']['app_name'].nil?
  virtualenv node['newrelic']['python_agent']['python_venv'] unless node['newrelic']['python_agent']['python_venv'].nil?
  version node['newrelic']['python_agent']['python_version'] unless node['newrelic']['python_agent']['python_version'].nil?
  high_security NewRelic.to_boolean(node['newrelic']['application_monitoring']['high_security']) unless node['newrelic']['application_monitoring']['high_security'].nil?
  enabled NewRelic.to_boolean(node['newrelic']['application_monitoring']['enabled']) unless node['newrelic']['application_monitoring']['enabled'].nil?
  logfile node['newrelic']['application_monitoring']['logfile'] unless node['newrelic']['application_monitoring']['logfile'].nil?
  loglevel node['newrelic']['application_monitoring']['loglevel'] unless node['newrelic']['application_monitoring']['loglevel'].nil?
  daemon_ssl NewRelic.to_boolean(node['newrelic']['application_monitoring']['daemon']['ssl']) unless node['newrelic']['application_monitoring']['daemon']['ssl'].nil?
  capture_params NewRelic.to_boolean(node['newrelic']['application_monitoring']['capture_params']) unless node['newrelic']['application_monitoring']['capture_params'].nil?
  ignored_params node['newrelic']['application_monitoring']['ignored_params'] unless node['newrelic']['application_monitoring']['ignored_params'].nil?
  transaction_tracer_enable NewRelic.to_boolean(node['newrelic']['application_monitoring']['transaction_tracer']['enable']) unless node['newrelic']['application_monitoring']['transaction_tracer']['enable'].nil?
  transaction_tracer_threshold node['newrelic']['application_monitoring']['transaction_tracer']['threshold'] unless node['newrelic']['application_monitoring']['transaction_tracer']['threshold'].nil?
  transaction_tracer_record_sql node['newrelic']['application_monitoring']['transaction_tracer']['record_sql'] unless node['newrelic']['application_monitoring']['transaction_tracer']['record_sql'].nil?
  transaction_tracer_stack_trace_threshold node['newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold'] unless node['newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold'].nil?
  transaction_tracer_slow_sql NewRelic.to_boolean(node['newrelic']['application_monitoring']['transaction_tracer']['slow_sql']) unless node['newrelic']['application_monitoring']['transaction_tracer']['slow_sql'].nil?
  transaction_tracer_explain_threshold node['newrelic']['application_monitoring']['transaction_tracer']['explain_threshold'] unless node['newrelic']['application_monitoring']['transaction_tracer']['explain_threshold'].nil?
  error_collector_enable NewRelic.to_boolean(node['newrelic']['application_monitoring']['error_collector']['enable']) unless node['newrelic']['application_monitoring']['error_collector']['enable'].nil?
  error_collector_ignore_errors node['newrelic']['application_monitoring']['error_collector']['ignore_errors'] unless node['newrelic']['application_monitoring']['error_collector']['ignore_errors'].nil?
  browser_monitoring_auto_instrument NewRelic.to_boolean(node['newrelic']['application_monitoring']['browser_monitoring']['auto_instrument']) unless node['newrelic']['application_monitoring']['browser_monitoring']['auto_instrument'].nil?
  cross_application_tracer_enable NewRelic.to_boolean(node['newrelic']['application_monitoring']['cross_application_tracer']['enable']) unless node['newrelic']['application_monitoring']['cross_application_tracer']['enable']
  feature_flag node['newrelic']['python_agent']['feature_flag'] unless node['newrelic']['python_agent']['feature_flag'].nil?
  thread_profiler_enable NewRelic.to_boolean(node['newrelic']['application_monitoring']['thread_profiler']['enable']) unless node['newrelic']['application_monitoring']['thread_profiler']['enable'].nil?
end
