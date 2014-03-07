#
# Cookbook Name:: newrelic
# Attributes:: meetme-plugin-agent
#
# Copyright 2012-2013, Escape Studios
#

default['newrelic']['meetme_plugin_agent']['python_recipe'] = "python::pip"
default['newrelic']['meetme_plugin_agent']['service_name'] = "newrelic-plugin-agent"
default['newrelic']['meetme_plugin_agent']['wake_interval'] = 60
default['newrelic']['meetme_plugin_agent']['proxy'] = nil
default['newrelic']['meetme_plugin_agent']['services'] = {}
default['newrelic']['meetme_plugin_agent']['config_file'] = "/etc/newrelic/newrelic_plugin_agent.cfg"
default['newrelic']['meetme_plugin_agent']['pid_file'] = "/var/run/newrelic/newrelic_plugin_agent.pid"
default['newrelic']['meetme_plugin_agent']['log_file'] = "/var/log/newrelic/newrelic_plugin_agent.log"
default['newrelic']['meetme_plugin_agent']['user'] = "newrelic"
default['newrelic']['meetme_plugin_agent']['additional_requirements'] = {}