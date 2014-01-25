#
# Cookbook Name:: newrelic
# Attributes:: java-agent
#
# Copyright 2012-2014, Escape Studios
#

default['newrelic']['https_download'] = 'https://download.newrelic.com/newrelic/java-agent/newrelic-agent/2.21.3/newrelic-agent-2.21.3.jar'
default['newrelic']['jar_file'] = 'newrelic-agent-2.21.3.jar'
default['newrelic']['install_dir'] = ''
default['newrelic']['app_user'] = 'newrelic'
default['newrelic']['app_group'] = 'newrelic'
default['newrelic']['audit_mode'] = false
default['newrelic']['log_file_count'] = 1
default['newrelic']['log_limit_in_kbytes'] = 0
default['newrelic']['log_daily'] = true