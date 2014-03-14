#
# Cookbook Name:: newrelic
# Attributes:: repository
#
# Copyright 2012-2014, Escape Studios
#

case node['platform_family']
when 'debian'
  default['newrelic']['repo']['uri'] = 'http://download.newrelic.com/debian/'
  default['newrelic']['repo']['key'] = 'http://download.newrelic.com/548C16BF.gpg'
  default['newrelic']['repo']['distribution'] = 'newrelic'
  default['newrelic']['repo']['components'] = ['non-free']
when 'rhel'
  default['newrelic']['repo']['uri'] = 'http://download.newrelic.com/pub/newrelic/el5/$basearch/'
  default['newrelic']['repo']['key'] = 'http://download.newrelic.com/548C16BF.gpg'
end
