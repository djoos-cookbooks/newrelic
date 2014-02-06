#
# Cookbook Name:: newrelic
# Recipe:: ruby-agent
#
# Copyright 2012-2014, Escape Studios
#

package 'newrelic_rpm' do
    provider Chef::Provider::Package::RubyGem
    action :install
end

if node['newrelic']['application_monitoring']['appname'].nil?
    node.set['newrelic']['application_monitoring']['appname'] = node['hostname']
end

#configure your New Relic license key
conf_file = node['newrelic']['install_dir'] + '/newrelic.yml'
template conf_file do
    source "newrelic.yml.erb"
    owner node['newrelic']['app_user']
    group node['newrelic']['app_group']
    mode 0644
    variables(
        :license => node['newrelic']['application_monitoring']['license'],
        :appname => node['newrelic']['application_monitoring']['appname'],
        :logfile => node['newrelic']['application_monitoring']['logfile'],
        :loglevel => node['newrelic']['application_monitoring']['loglevel'],
        :audit_mode => node['newrelic']['audit_mode'], 
        :log_file_count => node['newrelic']['log_file_count'],
        :log_limit_in_kbytes => node['newrelic']['log_limit_in_kbytes'],
        :log_daily => node['newrelic']['log_daily'], 
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