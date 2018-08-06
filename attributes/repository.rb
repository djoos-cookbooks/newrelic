#
# Cookbook Name:: newrelic
# Attributes:: repository
#
# Copyright (c) 2016, David Joos
#

default['newrelic']['repository']['key'] = 'http://download.newrelic.com/548C16BF.gpg'
default['newrelic']['repository']['ssl_verify'] = true
case node['platform_family']
when 'debian'
  default['newrelic']['repository']['uri'] = 'http://download.newrelic.com/debian/'
  default['newrelic']['repository']['distribution'] = 'newrelic'
  default['newrelic']['repository']['components'] = ['non-free']
when 'rhel', 'fedora', 'amazon'
  default['newrelic']['repository']['uri'] = 'http://download.newrelic.com/pub/newrelic/el5/$basearch/'
  default['newrelic']['repository']['proxy'] = node['newrelic']['proxy']
  default['newrelic']['repository']['proxy_username'] = nil
  default['newrelic']['repository']['proxy_password'] = nil
end

# New Relic infrastructure repository
default['newrelic']['repository']['infrastructure']['key'] = 'https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg'
default['newrelic']['repository']['infrastructure']['ssl_verify'] = true
case node['platform_family']
when 'debian'
  default['newrelic']['repository']['infrastructure']['uri'] = 'https://download.newrelic.com/infrastructure_agent/linux/apt'
  default['newrelic']['repository']['infrastructure']['components'] = ['main']
when 'rhel', 'fedora'
  rhel_version = node['platform_version'].to_i
  default['newrelic']['repository']['infrastructure']['uri'] = "https://download.newrelic.com/infrastructure_agent/linux/yum/el/#{rhel_version}/x86_64"
when 'amazon'
  case node['platform_version'].to_i
  when 2
    rhel_version = 7
  when 2013, 2014, 2015, 2016, 2017, 2018
    rhel_version = 6
  end
  default['newrelic']['repository']['infrastructure']['uri'] = "https://download.newrelic.com/infrastructure_agent/linux/yum/el/#{rhel_version}/x86_64"
end
