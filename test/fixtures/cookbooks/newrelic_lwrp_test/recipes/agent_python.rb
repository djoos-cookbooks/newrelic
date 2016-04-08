# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: agent_python
#
# Copyright 2012-2015, Escape Studios
#

include_recipe 'python'

newrelic_agent_python 'Install' do
  license node['newrelic']['license']
  config_file '/etc/newrelic/newrelic.ini'
  cookbook 'newrelic'
  source 'agent/python/newrelic.ini.erb'
  app_name 'my_python_app'
  enabled true
  logfile '/etc/newrelic/log.log'
  loglevel 'debug'
  high_security false
  daemon_ssl false
  capture_params true
  transaction_tracer_enable true
  transaction_tracer_threshold 'apdex_f'
  transaction_tracer_record_sql 'off'
  transaction_tracer_stack_trace_threshold '0.6'
  transaction_tracer_slow_sql false
  transaction_tracer_explain_threshold '0.7'
  thread_profiler_enable false
  error_collector_enable false
  browser_monitoring_auto_instrument true
  cross_application_tracer_enable false
end

# newrelic_agent_python 'remove' do
#  action :remove
# end
