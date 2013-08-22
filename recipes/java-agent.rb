
#Create the directory to install the jar into
directory node['newrelic']['java']['install_dir'] do
  action :create
end

local_file = node['newrelic']['java']['install_dir'] + '/newrelic.jar'
remote_file local_file do
  source   node['newrelic']['java']['https_download_url']
  owner node['newrelic']['java']['app_user']
  group node['newrelic']['java']['app_group']
  mode 0644
end

if node['newrelic']['application_monitoring']['appname'].nil?
  node.set['newrelic']['application_monitoring']['appname'] = node['hostname']
end   

#configure your New Relic license key
conf_file = node['newrelic']['java']['install_dir'] + '/newrelic.yml'
template conf_file do
    source "newrelic.yml.java.erb"
    owner node['newrelic']['java']['app_user']
    group node['newrelic']['java']['app_group']
    mode 0644
    variables(
        :license => node['newrelic']['application_monitoring']['license'],
        :appname => node['newrelic']['application_monitoring']['appname'],
        :logfile => node['newrelic']['application_monitoring']['logfile'],
        :loglevel => node['newrelic']['application_monitoring']['loglevel'],
        :audit_mode => node['newrelic']['java']['audit_mode'], 
        :log_file_count => node['newrelic']['java']['log_file_count'],
        :log_limit_in_kbytes => node['newrelic']['java']['log_limit_in_kbytes'],
        :log_daily => node['newrelic']['java']['log_daily'], 
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