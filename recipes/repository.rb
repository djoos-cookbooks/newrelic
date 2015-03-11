#
# Cookbook Name:: newrelic
# Recipe:: repository
#
# Copyright 2012-2014, Escape Studios
#

case node['platform']
when 'debian', 'ubuntu', 'redhat', 'centos', 'fedora', 'scientific', 'amazon'
  package 'wget'
end

case node['platform']
when 'debian', 'ubuntu'
  apt_repository "newrelic" do
    uri "http://apt.newrelic.com/debian/"
    distribution "newrelic"
    components ["non-free"]
    keyserver "keyserver.ubuntu.com"
    key node['newrelic']['repository']['repository_key']
  end

when 'redhat', 'centos', 'fedora', 'scientific', 'amazon'
  # install the newrelic-repo package, which configures a new package repository for yum
  if node['kernel']['machine'] == 'x86_64'
    machine = 'x86_64'
  else
    machine = 'i386'
  end

  remote_file "#{Chef::Config[:file_cache_path]}/newrelic-repo-5-3.noarch.rpm" do
    source "http://download.newrelic.com/pub/newrelic/el5/#{machine}/newrelic-repo-5-3.noarch.rpm"
    action :create_if_missing
  end

  package 'newrelic-repo' do
    source "#{Chef::Config[:file_cache_path]}/newrelic-repo-5-3.noarch.rpm"
    provider Chef::Provider::Package::Rpm
    action node['newrelic']['repository']['repository_action']
  end
end
