#
# Cookbook:: newrelic_lwrp_test
# Recipe:: agent_python_recipe
#
# Copyright:: (c) 2016, David Joos
#

node.default['newrelic']['application_monitoring']['app_name'] = 'My Python Application'
node.default['newrelic']['application_monitoring']['error_collector']['enable'] = 'false'
node.default['newrelic']['application_monitoring']['transaction_tracer']['enable'] = true
node.default['newrelic']['application_monitoring']['enabled'] = 'true'

include_recipe 'newrelic::python_agent'
