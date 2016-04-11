
# Cookbook Name:: newrelic
# Attributes:: docker_agent
#
# Copyright 2012-2015, Escape Studios
#

default['newrelic']['docker_agent']['service_name'] = 'docker'
default['newrelic']['docker_agent']['app_user'] = 'newrelic'
default['newrelic']['docker_agent']['app_group'] = 'docker'
