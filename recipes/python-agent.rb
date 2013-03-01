#
# Cookbook Name:: newrelic
# Recipe:: python-agent
#
# Copyright 2012-2013, Escape Studios
#

include_recipe "python::pip"

#install latest python agent
python_pip "newrelic" do
    action :install
    if node[:newrelic][:python_version] != "latest"
        version "#{node[:newrelic][:python_version]}"
    end
end

#configure your New Relic license key
template "/etc/newrelic/newrelic.ini" do
    source "newrelic.ini.python.erb"
    owner "root"
    group "root"
    mode "0644"
    variables(
        :license => node[:newrelic][:application_monitoring][:license],
        :appname => node[:newrelic][:application_monitoring][:appname],
        :enabled => node[:newrelic][:application_monitoring][:enabled],
        :logfile => node[:newrelic][:application_monitoring][:logfile],
        :loglevel => node[:newrelic][:application_monitoring][:loglevel],
        :daemon_ssl => node[:newrelic][:application_monitoring][:daemon][:ssl],        
        :capture_params => node[:newrelic][:application_monitoring][:capture_params],
        :ignored_params => node[:newrelic][:application_monitoring][:ignored_params],
        :transaction_tracer_enable => node[:newrelic][:application_monitoring][:transaction_tracer][:enable],
        :transaction_tracer_threshold => node[:newrelic][:application_monitoring][:transaction_tracer][:threshold],
        :transaction_tracer_record_sql => node[:newrelic][:application_monitoring][:transaction_tracer][:record_sql],
        :transaction_tracer_stack_trace_threshold => node[:newrelic][:application_monitoring][:transaction_tracer][:stack_trace_threshold],
        :transaction_tracer_slow_sql => node[:newrelic][:application_monitoring][:transaction_tracer][:slow_sql],
        :transaction_tracer_explain_threshold => node[:newrelic][:application_monitoring][:transaction_tracer][:explain_threshold],
        :error_collector_enable => node[:newrelic][:application_monitoring][:error_collector][:enable],
        :browser_monitoring_auto_instrument => node[:newrelic][:application_monitoring][:browser_monitoring][:auto_instrument]
    )
    action :create
end
