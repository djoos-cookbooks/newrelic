#
# Cookbook Name:: newrelic
# Attributes:: python_agent
#
# Copyright (c) 2016, David Joos
#

default['newrelic']['python_agent']['agent_action'] = 'install'
default['newrelic']['python_agent']['python_version'] = nil
default['newrelic']['python_agent']['python_venv'] = nil
default['newrelic']['python_agent']['config_file'] = '/etc/newrelic/newrelic.ini'
default['newrelic']['python_agent']['template']['cookbook'] = 'newrelic'
default['newrelic']['python_agent']['template']['source'] = 'agent/python/newrelic.ini.erb'
default['newrelic']['python_agent']['feature_flag'] = nil
