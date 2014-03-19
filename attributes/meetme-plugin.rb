#
# Cookbook Name:: newrelic
# Attributes:: meetme-plugin
#
# Copyright 2012-2013, Escape Studios
#

default['newrelic']['meetme-plugin']['python_recipe'] = "python::pip"
default['newrelic']['meetme-plugin']['service_name'] = "newrelic-plugin-agent"
default['newrelic']['meetme-plugin']['wake_interval'] = 60
default['newrelic']['meetme-plugin']['proxy'] = nil
default['newrelic']['meetme-plugin']['services'] = {}
default['newrelic']['meetme-plugin']['config_file'] = "/etc/newrelic/newrelic_plugin_agent.cfg"
default['newrelic']['meetme-plugin']['pid_file'] = "/var/run/newrelic/newrelic_plugin_agent.pid"
default['newrelic']['meetme-plugin']['log_file'] = "/var/log/newrelic/newrelic_plugin_agent.log"
default['newrelic']['meetme-plugin']['user'] = "newrelic"
default['newrelic']['meetme-plugin']['additional_requirements'] = {}