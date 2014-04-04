#
# Cookbook Name:: newrelic
# Attributes:: ruby-agent
#
# Copyright 2012-2014, Escape Studios
#

default['newrelic']['ruby-agent']['install_dir'] = ''
default['newrelic']['ruby-agent']['app_user'] = 'newrelic'
default['newrelic']['ruby-agent']['app_group'] = 'newrelic'
default['newrelic']['ruby-agent']['audit_mode'] = false
default['newrelic']['ruby-agent']['log_file_count'] = 1
default['newrelic']['ruby-agent']['log_limit_in_kbytes'] = 0
default['newrelic']['ruby-agent']['log_daily'] = true
