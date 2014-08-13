#
# Cookbook Name:: newrelic
# Attributes:: repository
#
# Copyright 2012-2014, Escape Studios
#

# Apt
default['newrelic']['repository']['repository_key'] = '548C16BF'
default['newrelic']['repository']['repository_action'] = :install

# Yum
default['yum']['newrelic']['managed'] = true
default['yum']['newrelic']['name'] = 'newrelic'
default['yum']['newrelic']['description'] = 'New Relic packages for Enterprise Linux'
default['yum']['newrelic']['baseurl'] = "http://yum.newrelic.com/pub/newrelic/el5/#{node['kernel']['machine']}"
default['yum']['newrelic']['gpgcheck'] = true
default['yum']['newrelic']['gpgkey'] = 'https://raw.githubusercontent.com/escapestudios-cookbooks/newrelic/master/files/default/RPM-GPG-KEY-NewRelic.asc'
default['yum']['newrelic']['enabled'] = true
