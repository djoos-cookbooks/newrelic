#
# Cookbook Name:: newrelic
# Attributes:: java-agent
#
# Copyright 2012-2014, Escape Studios
#

default['newrelic']['java-agent']['version'] = '3.9.0'
version = node['newrelic']['java-agent']['version']
default['newrelic']['java-agent']['https_download'] = "https://download.newrelic.com/newrelic/java-agent/newrelic-agent/#{version}/newrelic-agent-#{version}.jar"
default['newrelic']['java-agent']['jar_file'] = "newrelic-agent-#{version}.jar"
default['newrelic']['java-agent']['install_dir'] = '/opt/newrelic/java'
default['newrelic']['java-agent']['app_user'] = 'newrelic'
default['newrelic']['java-agent']['app_group'] = 'newrelic'
default['newrelic']['java-agent']['audit_mode'] = false
default['newrelic']['java-agent']['log_file_count'] = 1
default['newrelic']['java-agent']['log_limit_in_kbytes'] = 0
default['newrelic']['java-agent']['log_daily'] = true
default['newrelic']['java-agent']['agent_action'] = 'install'
default['newrelic']['java-agent']['execute_agent_action'] = true
default['newrelic']['java-agent']['app_location'] = node['newrelic']['java-agent']['install_dir']
