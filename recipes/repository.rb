#
# Cookbook Name:: newrelic
# Recipe:: repository
#
# Copyright (c) 2016, David Joos
#

case node['platform_family']
when 'debian'
  apt_repository 'newrelic' do
    uri node['newrelic']['repository']['uri']
    distribution node['newrelic']['repository']['distribution']
    components node['newrelic']['repository']['components']
    key node['newrelic']['repository']['key']
  end
when 'rhel', 'fedora', 'amazon'
  yum_repository 'newrelic' do
    description 'New Relic packages for Enterprise Linux 5 - $basearch'
    baseurl node['newrelic']['repository']['uri']
    gpgkey node['newrelic']['repository']['key']
    sslverify node['newrelic']['repository']['ssl_verify']
    proxy node['newrelic']['repository']['proxy'] unless node['newrelic']['repository']['proxy'].nil?
    proxy_username node['newrelic']['repository']['proxy_username'] unless node['newrelic']['repository']['proxy_username'].nil?
    proxy_password node['newrelic']['repository']['proxy_password'] unless node['newrelic']['repository']['proxy_password'].nil?
  end
end
