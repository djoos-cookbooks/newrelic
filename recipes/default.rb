#
# Cookbook Name:: newrelic
# Recipe:: default
#
# Copyright 2012-2013, Escape Studios
#

include_recipe "newrelic::install"
include_recipe "newrelic::server-monitor"