#
# Cookbook Name:: newrelic
# Attributes:: nodejs-agent
#
# Copyright 2012-2013, Escape Studios
#

default['newrelic']['nodejs']['apps'] = []
default['newrelic']['nodejs_recipe'] = "nodejs::npm"