#
# Cookbook Name:: newrelic
# Recipe:: ruby-agent
#
# Copyright 2012-2014, Escape Studios
#

include_recipe 'newrelic::repository'

license = node['newrelic']['application_monitoring']['license']

gem_package 'newrelic_rpm' do
  action :install
end

if node['newrelic']['application_monitoring']['appname'].nil?
  node.set['newrelic']['application_monitoring']['appname'] = node['hostname']
end

# configure your New Relic license key
template "#{node['newrelic']['ruby-agent']['install_dir']}/newrelic.yml" do
  source 'agent/ruby/newrelic.yml.erb'
  owner node['newrelic']['ruby-agent']['app_user']
  group node['newrelic']['ruby-agent']['app_group']
  mode 0644
  variables(
    :license => license,
    :appname => node['newrelic']['application_monitoring']['appname'],
    :enabled => node['newrelic']['application_monitoring']['enabled'],
    :logfile => node['newrelic']['application_monitoring']['logfile'],
    :loglevel => node['newrelic']['application_monitoring']['loglevel'],
    :audit_mode => node['newrelic']['ruby-agent']['audit_mode'],
    :log_file_count => node['newrelic']['ruby-agent']['log_file_count'],
    :log_limit_in_kbytes => node['newrelic']['ruby-agent']['log_limit_in_kbytes'],
    :log_daily => node['newrelic']['ruby-agent']['log_daily'],
    :daemon_ssl => node['newrelic']['application_monitoring']['daemon']['ssl'],
    :capture_params => node['newrelic']['application_monitoring']['capture_params'],
    :ignored_params => node['newrelic']['application_monitoring']['ignored_params'],
    :transaction_tracer_enable => node['newrelic']['application_monitoring']['transaction_tracer']['enable'],
    :transaction_tracer_threshold => node['newrelic']['application_monitoring']['transaction_tracer']['threshold'],
    :transaction_tracer_record_sql => node['newrelic']['application_monitoring']['transaction_tracer']['record_sql'],
    :transaction_tracer_stack_trace_threshold => node['newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold'],
    :transaction_tracer_slow_sql => node['newrelic']['application_monitoring']['transaction_tracer']['slow_sql'],
    :transaction_tracer_explain_threshold => node['newrelic']['application_monitoring']['transaction_tracer']['explain_threshold'],
    :error_collector_enable => node['newrelic']['application_monitoring']['error_collector']['enable'],
    :browser_monitoring_auto_instrument => node['newrelic']['application_monitoring']['browser_monitoring']['auto_instrument'],
    :cross_application_tracer_enable => node['newrelic']['application_monitoring']['cross_application_tracer']['enable']
  )
  action :create
end
