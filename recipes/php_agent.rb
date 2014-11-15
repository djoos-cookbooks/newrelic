#
# Cookbook Name:: newrelic
# Recipe:: php_agent
#
# Copyright 2012-2014, Escape Studios
#

include_recipe 'newrelic::repository'

license = NewRelic.application_monitoring_license(node)

# the older version (3.0) had a bug in the init scripts that when it shut down the daemon
# it would also kill dpkg as it was trying to upgrade let's remove the old package before continuing
package 'newrelic-php5-broken' do
  # set package_name attribute explicitly as the name attribute is *not* the correct package name
  # so not to clash with the package resource block below... (see issue #109 for more information)
  package_name 'newrelic-php5'
  action :remove
  version '3.0.5.95'
end

# install/update latest php agent
package 'newrelic-php5' do
  action node['newrelic']['php_agent']['agent_action']
  notifies :run, 'execute[newrelic-install]', :immediately
end

# run newrelic-install
execute 'newrelic-install' do
  command 'newrelic-install install'
  if node['newrelic']['php_agent']['install_silently']
    environment(
      'NR_INSTALL_SILENT' => '1'
    )
  end
  action :nothing
  if node['newrelic']['php_agent']['web_server']['service_name']
    notifies :restart, "service[#{node['newrelic']['php_agent']['web_server']['service_name']}]", :delayed
  end
end

service 'newrelic-daemon' do
  supports :status => true, :start => true, :stop => true, :restart => true
end

# run php5enmod newrelic
execute 'newrelic-php5enmod' do
  command 'php5enmod newrelic'
  action :nothing
  only_if { node['newrelic']['php_agent']['execute_php5enmod'] }
end

# configure New Relic INI file and set the daemon related options (documented at /usr/lib/newrelic-php5/scripts/newrelic.ini.template)
# and restart the web server in order to pick up the new settings
template node['newrelic']['php_agent']['config_file'] do
  cookbook node['newrelic']['php_agent']['template']['cookbook_ini']
  source node['newrelic']['php_agent']['template']['source_ini']
  owner 'root'
  group 'root'
  mode 0644
  variables(
    :enabled => node['newrelic']['application_monitoring']['enabled'],
    :license => license,
    :logfile => node['newrelic']['application_monitoring']['logfile'],
    :loglevel => node['newrelic']['application_monitoring']['loglevel'],
    :app_name => node['newrelic']['application_monitoring']['app_name'],
    :daemon_logfile => node['newrelic']['application_monitoring']['daemon']['logfile'],
    :daemon_loglevel => node['newrelic']['application_monitoring']['daemon']['loglevel'],
    :daemon_port => node['newrelic']['application_monitoring']['daemon']['port'],
    :daemon_max_threads => node['newrelic']['application_monitoring']['daemon']['max_threads'],
    :daemon_ssl => node['newrelic']['application_monitoring']['daemon']['ssl'],
    :daemon_ssl_ca_path => node['newrelic']['application_monitoring']['daemon']['ssl_ca_path'],
    :daemon_ssl_ca_bundle => node['newrelic']['application_monitoring']['daemon']['ssl_ca_bundle'],
    :daemon_proxy => node['newrelic']['application_monitoring']['daemon']['proxy'],
    :daemon_pidfile => node['newrelic']['application_monitoring']['daemon']['pidfile'],
    :daemon_location => node['newrelic']['application_monitoring']['daemon']['location'],
    :daemon_collector_host => node['newrelic']['application_monitoring']['daemon']['collector_host'],
    :daemon_dont_launch => node['newrelic']['application_monitoring']['daemon']['dont_launch'],
    :capture_params => node['newrelic']['application_monitoring']['capture_params'],
    :ignored_params => node['newrelic']['application_monitoring']['ignored_params'],
    :error_collector_enable => node['newrelic']['application_monitoring']['error_collector']['enable'],
    :error_collector_record_database_errors => node['newrelic']['application_monitoring']['error_collector']['record_database_errors'],
    :error_collector_prioritize_api_errors => node['newrelic']['application_monitoring']['error_collector']['prioritize_api_errors'],
    :browser_monitoring_auto_instrument => node['newrelic']['application_monitoring']['browser_monitoring']['auto_instrument'],
    :transaction_tracer_enable => node['newrelic']['application_monitoring']['transaction_tracer']['enable'],
    :transaction_tracer_threshold => node['newrelic']['application_monitoring']['transaction_tracer']['threshold'],
    :transaction_tracer_detail => node['newrelic']['application_monitoring']['transaction_tracer']['detail'],
    :transaction_tracer_slow_sql => node['newrelic']['application_monitoring']['transaction_tracer']['slow_sql'],
    :transaction_tracer_stack_trace_threshold => node['newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold'],
    :transaction_tracer_explain_threshold => node['newrelic']['application_monitoring']['transaction_tracer']['explain_threshold'],
    :transaction_tracer_record_sql => node['newrelic']['application_monitoring']['transaction_tracer']['record_sql'],
    :transaction_tracer_custom => node['newrelic']['application_monitoring']['transaction_tracer']['custom'],
    :framework => node['newrelic']['application_monitoring']['framework'],
    :webtransaction_name_remove_trailing_path => node['newrelic']['application_monitoring']['webtransaction']['name']['remove_trailing_path'],
    :webtransaction_name_functions => node['newrelic']['application_monitoring']['webtransaction']['name']['functions'],
    :webtransaction_name_files => node['newrelic']['application_monitoring']['webtransaction']['name']['files'],
    :cross_application_tracer_enable => node['newrelic']['application_monitoring']['cross_application_tracer']['enable']
  )
  action :create
  if node['newrelic']['php_agent']['execute_php5enmod']
    notifies :run, 'execute[newrelic-php5enmod]', :immediately
  end
  if node['newrelic']['php_agent']['web_server']['service_name']
    notifies :restart, "service[#{node['newrelic']['php_agent']['web_server']['service_name']}]", :delayed
  end
end

# https://newrelic.com/docs/php/newrelic-daemon-startup-modes
log "newrelic-daemon startup mode: #{node['newrelic']['php_agent']['startup_mode']}" do
  level :info
end

case node['newrelic']['php_agent']['startup_mode']
when 'agent'
  # agent startup mode

  # ensure that the daemon isn't currently running
  service 'newrelic-daemon' do
    action [:disable, :stop] # stops the service if it's running and disables it from starting at system boot time
  end

  # ensure that the file /etc/newrelic/newrelic.cfg does not exist if it does, move it aside (or remove it)
  execute 'newrelic-backup-cfg' do
    command 'mv /etc/newrelic/newrelic.cfg /etc/newrelic/newrelic.cfg.external'
    only_if { File.exist?('/etc/newrelic/newrelic.cfg') }
  end

  # ensure that the file /etc/newrelic/upgrade_please.key does not exist if it does, move it aside (or remove it)
  execute 'newrelic-backup-key' do
    command 'mv /etc/newrelic/upgrade_please.key /etc/newrelic/upgrade_please.key.external'
    only_if { File.exist?('/etc/newrelic/upgrade_please.key') }
  end
when 'external'
  # external startup mode

  # configure proxy daemon settings
  template '/etc/newrelic/newrelic.cfg' do
    cookbook node['newrelic']['php_agent']['template']['cookbook']
    source node['newrelic']['php_agent']['template']['source']
    owner 'root'
    group 'root'
    mode 0644
    variables(
      :daemon_pidfile => node['newrelic']['application_monitoring']['daemon']['pidfile'],
      :daemon_logfile => node['newrelic']['application_monitoring']['daemon']['logfile'],
      :daemon_loglevel => node['newrelic']['application_monitoring']['daemon']['loglevel'],
      :daemon_port => node['newrelic']['application_monitoring']['daemon']['port'],
      :daemon_ssl => node['newrelic']['application_monitoring']['daemon']['ssl'],
      :daemon_proxy => node['newrelic']['application_monitoring']['daemon']['proxy'],
      :daemon_ssl_ca_path => node['newrelic']['application_monitoring']['daemon']['ssl_ca_path'],
      :daemon_ssl_ca_bundle => node['newrelic']['application_monitoring']['daemon']['ssl_ca_bundle'],
      :daemon_max_threads => node['newrelic']['application_monitoring']['daemon']['max_threads'],
      :daemon_collector_host => node['newrelic']['application_monitoring']['daemon']['collector_host']
    )
    action :create
    notifies :restart, 'service[newrelic-daemon]', :immediately
    if node['newrelic']['php_agent']['web_server']['service_name']
      notifies :restart, "service[#{node['newrelic']['php_agent']['web_server']['service_name']}]", :delayed
    end
  end

  service 'newrelic-daemon' do
    action [:enable, :start] # starts the service if it's not running and enables it to start at system boot time
  end
else
  Chef::Application.fatal!("#{node['newrelic']['php_agent']['startup_mode']} is not a valid newrelic-daemon startup mode.")
end

# only used for ChefSpec-purposes
# we don't want to redeclare node['newrelic']['php_agent']['web_server']['service_name'] (eg. apache2)
# so decided to add a 'stub_service' to the resource collection which can then be used in the unit test(s)
service 'stub_service' do
  action :nothing
end
