# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: agent_python_recipe
#
# Copyright 2012-2015, Escape Studios
#

node.default['newrelic']['application_monitoring']['app_name'] = 'My Python Application'
node.default['newrelic']['application_monitoring']['error_collector']['enable'] = 'false'
node.default['newrelic']['application_monitoring']['transaction_tracer']['enable'] = true
node.default['newrelic']['application_monitoring']['enabled'] = 'true'

include_recipe 'python'
include_recipe 'newrelic::python_agent'
