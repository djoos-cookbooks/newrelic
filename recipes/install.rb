#
# Cookbook Name:: newrelic
# Recipe:: install
#
# Copyright 2012-2013, Escape Studios
#

include_recipe "newrelic::repository"
include_recipe "newrelic::server-monitor"
