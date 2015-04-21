# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: java_agent
#
# Copyright 2015, Rackspace
#

user 'newrelic'

include_recipe 'java'
include_recipe 'tomcat'
include_recipe 'newrelic::java_agent'
