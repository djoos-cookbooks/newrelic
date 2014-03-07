#
# Cookbook Name:: newrelic
# Attributes:: python-agent
#
# Copyright 2012-2014, Escape Studios
#

default['newrelic']['python-agent']['python_version'] = "latest"
default['newrelic']['python-agent']['python_recipe'] = "python::pip"