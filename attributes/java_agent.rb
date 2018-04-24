#
# Cookbook Name:: newrelic
# Attributes:: java_agent
#
# Copyright (c) 2016, David Joos
#

default['newrelic']['java_agent']['version'] = 'latest'
default['newrelic']['java_agent']['install_dir'] = '/opt/newrelic/java'
default['newrelic']['java_agent']['app_user'] = 'newrelic'
default['newrelic']['java_agent']['app_group'] = 'newrelic'
default['newrelic']['java_agent']['repository'] = 'https://download.newrelic.com/newrelic/java-agent/newrelic-agent'
default['newrelic']['java_agent']['audit_mode'] = false
default['newrelic']['java_agent']['log_file_count'] = 1
default['newrelic']['java_agent']['log_limit_in_kbytes'] = 0
default['newrelic']['java_agent']['log_daily'] = true
default['newrelic']['java_agent']['agent_action'] = 'install'
default['newrelic']['java_agent']['execute_agent_action'] = true
default['newrelic']['java_agent']['enable_custom_tracing'] = false
default['newrelic']['java_agent']['class_transformer_config'] = {}
# Example:
# default['newrelic']['java_agent']['class_transformer_config'] = {
#   'classloader_blacklist' => ['org.codehaus.groovy.runtime.callsite.CallSiteClassLoader'],
#   'instrumentation_classes' => {
#    'wildfly-8' => { 'enabled' => false },
#    'wildfly-8-CAT' => { 'enabled' => false },
#    'wildfly-8-PORT' => { 'enabled' => false }
#   }
# }
#
default['newrelic']['java_agent']['app_location'] = node['newrelic']['java_agent']['install_dir']
default['newrelic']['java_agent']['template']['cookbook'] = 'newrelic'
default['newrelic']['java_agent']['template']['source'] = 'agent/newrelic.yml.erb'
