#
# Cookbook Name:: newrelic
# Attributes:: server-monitor
#
# Copyright 2012-2013, Escape Studios
#

case node['platform']
when "windows"
  default['newrelic']['service_name'] = "NewRelic.ServerMonitor.Service"
else
  default['newrelic']['service_name'] = "newrelic-sysmond"
  default['newrelic']['config_path'] = "/etc/newrelic"
  default['newrelic']['config_file_group'] = "newrelic"
end
