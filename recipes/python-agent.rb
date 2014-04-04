#
# Cookbook Name:: newrelic
# Recipe:: python-agent
#
# Copyright 2012-2014, Escape Studios
#

include_recipe 'newrelic::repository'
include_recipe node['newrelic']['python-agent']['python_recipe']

license = node['newrelic']['application_monitoring']['license']

# install latest python agent
python_pip 'newrelic' do
  if node['newrelic']['python-agent']['python_venv']
    virtualenv node['newrelic']['python-agent']['python_venv']
  end
  action :install
  if node['newrelic']['python-agent']['python_version'] != 'latest'
    version node['newrelic']['python-agent']['python_version']
  end
end

# configure your New Relic license key
template node['newrelic']['python-agent']['config_file'] do
  source 'agent/python/newrelic.ini.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(
    :license => license,
    :appname => node['newrelic']['application_monitoring']['appname'],
    :enabled => node['newrelic']['application_monitoring']['enabled'],
    :logfile => node['newrelic']['application_monitoring']['logfile'],
    :loglevel => node['newrelic']['application_monitoring']['loglevel'],
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
    :browser_monitoring_auto_instrument => node['newrelic']['application_monitoring']['browser_monitoring']['auto_instrument']
  )
  action :create
end
