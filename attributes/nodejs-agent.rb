#
# Cookbook Name:: newrelic
# Attributes:: nodejs-agent
#
# Copyright 2012-2014, Escape Studios
#

default['newrelic']['agent_type'] = 'nodejs'
default['newrelic']['nodejs-agent']['agent_action'] = 'install'
default['newrelic']['nodejs-agent']['apps'] = []
default['newrelic']['nodejs-agent']['nodejs_recipe'] = 'nodejs::npm'
