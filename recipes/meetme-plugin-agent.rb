#
# Cookbook Name:: newrelic
# Recipe:: meetme-plugin-agent
#
# Copyright 2012-2013, Escape Studios
#

include_recipe node['newrelic']['meetme-plugin-agent']['python_recipe']

license = get_newrelic_license('plugin_monitoring')

#install latest plugin agent
python_pip node['newrelic']['meetme-plugin-agent']['service_name'] do
    action :upgrade
end

#create the configuration, run and log directories,
#making sure they are writable by the user specified in the configuration file
files = [
    node['newrelic']['meetme-plugin-agent']['config_file'],
    node['newrelic']['meetme-plugin-agent']['pid_file'],
    node['newrelic']['meetme-plugin-agent']['log_file']
]

files.each do |file|
    directory ::File.dirname(file) do
        owner node['newrelic']['meetme-plugin-agent']['user']
        group node['newrelic']['meetme-plugin-agent']['user']
        mode "0755"
    end
end

services_yml = nil
services = {
    '#services' => node['newrelic']['meetme-plugin-agent']['services']
}

unless services.nil?
    require 'yaml'
    #hack: Ruby YAML adds !ruby/hash:Chef::Node::ImmutableMash and !ruby/array:Chef::Node::ImmutableArray, lets remove them...
    services_yml = services.to_yaml(:indentation => 2).gsub("! '#services':", '#services:').gsub('---','').gsub('!ruby/hash:Chef::Node::ImmutableMash','').gsub('!ruby/array:Chef::Node::ImmutableArray','')
end

#configuration file
template node['newrelic']['meetme-plugin-agent']['config_file'] do
    source "meetme_plugin_agent.cfg.erb"
    owner "root"
    group "root"
    mode "0644"
    variables(
        :license_key => license,
        :wake_interval => node['newrelic']['meetme-plugin-agent']['wake_interval'],
        :proxy => node['newrelic']['meetme-plugin-agent']['proxy'],
        :services_yml => services_yml,
        :user => node['newrelic']['meetme-plugin-agent']['user'],
        :pid_file => node['newrelic']['meetme-plugin-agent']['pid_file'],
        :log_file => node['newrelic']['meetme-plugin-agent']['log_file']
    )
    action :create
    notifies :restart, "service[#{node['newrelic']['meetme-plugin-agent']['service_name']}]", :delayed
end

#installing additional requirement(s)
node['newrelic']['meetme-plugin-agent']['additional_requirements'].each do |additional_requirement|
    python_pip "newrelic_plugin_agent[#{additional_requirement}]" do
        action :upgrade
    end
end

#init script
variables = {
    :config_file => node['newrelic']['meetme-plugin-agent']['config_file'],
    :pid_file => node['newrelic']['meetme-plugin-agent']['pid_file']
}

case node['platform']
    when "debian", "ubuntu"
        variables[:user] = node['newrelic']['meetme-plugin-agent']['user']
        variables[:group] = node['newrelic']['meetme-plugin-agent']['user']
end

template "/etc/init.d/newrelic-plugin-agent" do
    source "meetme_plugin_agent_init.erb"
    mode "0755"
    variables(
        variables
    )
end

service node['newrelic']['meetme-plugin-agent']['service_name'] do
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:enable, :start] #starts the service if it's not running and enables it to start at system boot time
end