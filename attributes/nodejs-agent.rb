#
# Cookbook Name:: newrelic
# Attributes:: nodejs-agent
#
# Copyright 2012-2014, Escape Studios
#

default['newrelic']['nodejs']['apps'] = []
default['newrelic']['nodejs_recipe'] = "nodejs::npm"