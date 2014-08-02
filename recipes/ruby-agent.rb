#
# Cookbook Name:: newrelic
# Recipe:: ruby-agent
#
# Copyright 2012-2014, Escape Studios
#

include_recipe 'newrelic::repository'

license = node['newrelic']['application_monitoring']['license']

gem_package 'newrelic_rpm' do
  action node['newrelic']['ruby-agent']['agent_action']
end

if node['newrelic']['application_monitoring']['appname'].nil?
  node.set['newrelic']['application_monitoring']['appname'] = node['hostname']
end

# configure your New Relic license key
newrelic_yml "#{node['newrelic']['ruby-agent']['install_dir']}/newrelic.yml" do
  agent_type 'ruby'
  enabled node['newrelic']['application_monitoring']['enabled']
  app_name node['newrelic']['application_monitoring']['appname']
  owner node['newrelic']['ruby-agent']['app_user']
  group node['newrelic']['ruby-agent']['app_group']
  license license
  logfile node['newrelic']['application_monitoring']['logfile']
  logfile_path node['newrelic']['application_monitoring']['logfile_path']
  loglevel node['newrelic']['application_monitoring']['loglevel']
  audit_mode node['newrelic']['ruby-agent']['audit_mode']
  log_file_count node['newrelic']['ruby-agent']['log_file_count']
  log_limit_in_kbytes node['newrelic']['ruby-agent']['log_limit_in_kbytes']
  log_daily node['newrelic']['ruby-agent']['log_daily']
  daemon_ssl node['newrelic']['application_monitoring']['daemon']['ssl']
  capture_params node['newrelic']['application_monitoring']['capture_params']
  ignored_params node['newrelic']['application_monitoring']['ignored_params']
  transaction_tracer_enable node['newrelic']['application_monitoring']['transaction_tracer']['enable']
  transaction_tracer_threshold node['newrelic']['application_monitoring']['transaction_tracer']['threshold']
  transaction_tracer_record_sql node['newrelic']['application_monitoring']['transaction_tracer']['record_sql']
  transaction_tracer_stack_trace_threshold node['newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold']
  transaction_tracer_slow_sql node['newrelic']['application_monitoring']['transaction_tracer']['slow_sql']
  transaction_tracer_explain_threshold node['newrelic']['application_monitoring']['transaction_tracer']['explain_threshold']
  error_collector_enable node['newrelic']['application_monitoring']['error_collector']['enable']
  error_collector_ignore_errors node['newrelic']['application_monitoring']['error_collector']['ignore_errors']
  browser_monitoring_auto_instrument node['newrelic']['application_monitoring']['browser_monitoring']['auto_instrument']
  cross_application_tracer_enable node['newrelic']['application_monitoring']['cross_application_tracer']['enable']
end
