# plugin-agent
default['newrelic']['plugin-agent']['poll_interval'] = 60
default['newrelic']['plugin-agent']['pidfile'] = "/var/run/newrelic/newrelic_plugin_agent.pid"
default['newrelic']['plugin-agent']['logfile'] = "/var/log/newrelic/newrelic_plugin_agent.log"
default['newrelic']['plugin-agent']['service_config'] = ""

default['newrelic']['plugin-agent']['config_file'] = "#{node['newrelic']['config_path']}/newrelic_plugin_agent.cfg"
default['newrelic']['plugin-agent']['owner'] = "newrelic"
default['newrelic']['plugin-agent']['group'] = "newrelic"
default['newrelic']['plugin-agent']['mode'] = 00640
default['newrelic']['plugin-agent']['pip_package'] = "newrelic-plugin-agent"
