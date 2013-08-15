#
# Cookbook Name:: newrelic
# Attributes:: server-monitor
#
# Copyright 2012-2013, Escape Studios
#

default['newrelic']['service_name'] = value_for_platform(
    'smartos' => {'default' => 'nrsysmond'},
    'default' => 'newrelic-sysmond'
)
default['newrelic']['config_path'] = value_for_platform(
    'smartos' => {'default' => '/opt/local/etc'},
    'default' => '/etc/newrelic'
)
default['newrelic']['config_file_group'] = value_for_platform(
    'smartos' => {'default' => 'root'},
    'default' => 'newrelic'
)