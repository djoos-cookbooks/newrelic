#
# Cookbook Name:: newrelic
# Recipe:: repository
#
# Copyright 2012-2014, Escape Studios
#

case node['platform_family']
when 'debian'
  apt_repository 'newrelic' do
    uri node['newrelic']['repo']['uri']
    distribution node['newrelic']['repo']['distribution']
    components node['newrelic']['repo']['components']
    key node['newrelic']['repo']['key']
  end
when 'rhel'
  yum_repository 'newrelic' do
    description 'New Relic packages for Enterprise Linux 5 - $basearch'
    baseurl node['newrelic']['repo']['uri']
    gpgkey node['newrelic']['repo']['key']
  end
end
