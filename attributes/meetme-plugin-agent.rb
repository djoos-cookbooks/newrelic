#
# Cookbook Name:: newrelic
# Attributes:: meetme-plugin-agent
#
# Copyright 2012-2013, Escape Studios
#

default['newrelic']['meetme-plugin-agent']['python_recipe'] = "python::pip"
default['newrelic']['meetme-plugin-agent']['service_name'] = "newrelic-plugin-agent"
default['newrelic']['meetme-plugin-agent']['wake_interval'] = 60
default['newrelic']['meetme-plugin-agent']['proxy'] = nil
default['newrelic']['meetme-plugin-agent']['services'] = {}
default['newrelic']['meetme-plugin-agent']['config_file'] = "/etc/newrelic/newrelic_plugin_agent.cfg"
default['newrelic']['meetme-plugin-agent']['pid_file'] = "/var/run/newrelic/newrelic_plugin_agent.pid"
default['newrelic']['meetme-plugin-agent']['log_file'] = "/var/log/newrelic/newrelic_plugin_agent.log"
default['newrelic']['meetme-plugin-agent']['user'] = "newrelic"
default['newrelic']['meetme-plugin-agent']['additional_requirements'] = {}