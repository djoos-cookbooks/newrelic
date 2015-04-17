#
# Cookbook Name:: newrelic
# Recipe:: php_agent
#
# Copyright 2012-2015, Escape Studios
#

newrelic_agent_php 'Install' do
  license NewRelic.application_monitoring_license(node)
  config_file node['newrelic']['php_agent']['config_file']
  startup_mode node['newrelic']['php_agent']['startup_mode']
  app_name node['newrelic']['application_monitoring']['app_name']
  high_security NewRelic.to_string_from_boolean(node['newrelic']['application_monitoring']['high_security'])
  install_silently node['newrelic']['php_agent']['install_silently']
  config_file_to_be_deleted node['newrelic']['php_agent']['config_file_to_be_deleted']
  service_name node['newrelic']['php_agent']['web_server']['service_name']
  execute_php5enmod NewRelic.to_string_from_boolean(node['newrelic']['php_agent']['execute_php5enmod'])
  cookbook_ini node['newrelic']['php_agent']['template']['cookbook_ini']
  source_ini node['newrelic']['php_agent']['template']['source_ini']
  cookbook node['newrelic']['php_agent']['template']['cookbook']
  source node['newrelic']['php_agent']['template']['source']
  enabled node['newrelic']['application_monitoring']['enabled']
  logfile node['newrelic']['application_monitoring']['logfile']
  loglevel node['newrelic']['application_monitoring']['loglevel']
  daemon_logfile node['newrelic']['application_monitoring']['daemon']['logfile']
  daemon_loglevel node['newrelic']['application_monitoring']['daemon']['loglevel']
  daemon_port node['newrelic']['application_monitoring']['daemon']['port']
  daemon_max_threads node['newrelic']['application_monitoring']['daemon']['max_threads']
  daemon_ssl NewRelic.to_string_from_boolean(node['newrelic']['application_monitoring']['daemon']['ssl'])
  daemon_ssl_ca_path node['newrelic']['application_monitoring']['daemon']['ssl_ca_path']
  daemon_ssl_ca_bundle node['newrelic']['application_monitoring']['daemon']['ssl_ca_bundle']
  daemon_proxy node['newrelic']['application_monitoring']['daemon']['proxy']
  daemon_pidfile node['newrelic']['application_monitoring']['daemon']['pidfile']
  daemon_location node['newrelic']['application_monitoring']['daemon']['location']
  daemon_collector_host node['newrelic']['application_monitoring']['daemon']['collector_host']
  daemon_dont_launch node['newrelic']['application_monitoring']['daemon']['dont_launch']
  capture_params NewRelic.to_string_from_boolean(node['newrelic']['application_monitoring']['capture_params'])
  ignored_params node['newrelic']['application_monitoring']['ignored_params']
  error_collector_enable NewRelic.to_string_from_boolean(node['newrelic']['application_monitoring']['error_collector']['enable'])
  error_collector_record_database_errors NewRelic.to_string_from_boolean(node['newrelic']['application_monitoring']['error_collector']['record_database_errors'])
  error_collector_prioritize_api_errors NewRelic.to_string_from_boolean(node['newrelic']['application_monitoring']['error_collector']['prioritize_api_errors'])
  browser_monitoring_auto_instrument NewRelic.to_string_from_boolean(node['newrelic']['application_monitoring']['browser_monitoring']['auto_instrument'])
  transaction_tracer_enable NewRelic.to_string_from_boolean(node['newrelic']['application_monitoring']['transaction_tracer']['enable'])
  transaction_tracer_threshold node['newrelic']['application_monitoring']['transaction_tracer']['threshold']
  transaction_tracer_detail node['newrelic']['application_monitoring']['transaction_tracer']['detail']
  transaction_tracer_slow_sql NewRelic.to_string_from_boolean(node['newrelic']['application_monitoring']['transaction_tracer']['slow_sql'])
  transaction_tracer_stack_trace_threshold node['newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold']
  transaction_tracer_explain_threshold node['newrelic']['application_monitoring']['transaction_tracer']['explain_threshold']
  transaction_tracer_record_sql node['newrelic']['application_monitoring']['transaction_tracer']['record_sql']
  transaction_tracer_custom node['newrelic']['application_monitoring']['transaction_tracer']['custom']
  framework node['newrelic']['application_monitoring']['framework']
  webtransaction_name_remove_trailing_path NewRelic.to_string_from_boolean(node['newrelic']['application_monitoring']['webtransaction']['name']['remove_trailing_path'])
  webtransaction_name_functions node['newrelic']['application_monitoring']['webtransaction']['name']['functions']
  webtransaction_name_files node['newrelic']['application_monitoring']['webtransaction']['name']['files']
  cross_application_tracer_enable NewRelic.to_string_from_boolean(node['newrelic']['application_monitoring']['cross_application_tracer']['enable'])
end
