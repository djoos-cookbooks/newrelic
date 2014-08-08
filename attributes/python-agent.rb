#
# Cookbook Name:: newrelic
# Attributes:: python-agent
#
# Copyright 2012-2014, Escape Studios
#

default['newrelic']['agent_type'] = 'python'
default['newrelic']['python-agent']['agent_action'] = :install
default['newrelic']['python-agent']['python_version'] = 'latest'
default['newrelic']['python-agent']['python_recipe'] = 'python::pip'
default['newrelic']['python-agent']['python_venv'] = nil
default['newrelic']['python-agent']['config_file'] = '/etc/newrelic/newrelic.ini'
