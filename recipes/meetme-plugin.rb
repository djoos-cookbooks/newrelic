#
# Cookbook Name:: newrelic
# Recipe:: meetme-plugin
#
# Copyright 2012-2014, Escape Studios
#

include_recipe node['newrelic']['meetme-plugin']['python_recipe']

license = node['newrelic']['plugin_monitoring']['license']

# install latest plugin agent
python_pip node['newrelic']['meetme-plugin']['service_name'] do
  if node['newrelic']['python-agent']['python_venv']
    virtualenv node['newrelic']['python-agent']['python_venv']
  end
  action :upgrade
end

# create the configuration, run and log directories,
# making sure they are writable by the user specified in the configuration file
files = [
  node['newrelic']['meetme-plugin']['config_file'],
  node['newrelic']['meetme-plugin']['pid_file'],
  node['newrelic']['meetme-plugin']['log_file']
]

files.each do |file|
  directory ::File.dirname(file) do
    owner node['newrelic']['meetme-plugin']['user']
    group node['newrelic']['meetme-plugin']['user']
    mode 0755
  end
end

services_yml = nil
services = {
  '#services' => node['newrelic']['meetme-plugin']['services']
}

unless services.nil?
  require 'yaml'
  services_yml = services.to_yaml(:indentation => 2).gsub("! '#services':", '#services:').gsub('---', '').gsub(/!ruby\/[a-zA-Z:]*/, '')
end

# configuration file
template node['newrelic']['meetme-plugin']['config_file'] do
  source 'plugin/meetme/newrelic-plugin-agent.cfg.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(
    :license_key => license,
    :wake_interval => node['newrelic']['meetme-plugin']['wake_interval'],
    :proxy => node['newrelic']['meetme-plugin']['proxy'],
    :services_yml => services_yml,
    :user => node['newrelic']['meetme-plugin']['user'],
    :pid_file => node['newrelic']['meetme-plugin']['pid_file'],
    :log_file => node['newrelic']['meetme-plugin']['log_file']
  )
  action :create
  notifies :restart, "service[#{node['newrelic']['meetme-plugin']['service_name']}]", :delayed
end

# installing additional requirement(s)
node['newrelic']['meetme-plugin']['additional_requirements'].each do |additional_requirement|
  python_pip "newrelic-plugin-agent[#{additional_requirement}]" do
    action :upgrade
  end
end

# init script
variables = {
  :config_file => node['newrelic']['meetme-plugin']['config_file'],
  :pid_file => node['newrelic']['meetme-plugin']['pid_file']
}

case node['platform']
when 'debian', 'ubuntu'
  variables[:user] = node['newrelic']['meetme-plugin']['user']
  variables[:group] = node['newrelic']['meetme-plugin']['user']
end

template "/etc/init.d/#{node['newrelic']['meetme-plugin']['service_name']}" do
  source 'plugin/meetme/newrelic-plugin-agent.erb'
  mode 0755
  variables(
    variables
  )
end

service node['newrelic']['meetme-plugin']['service_name'] do
  supports :status => true, :start => true, :stop => true, :restart => true
  action [:enable, :start] # starts the service if it's not running and enables it to start at system boot time
end
