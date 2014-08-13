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

if platform_family?("debian")
  # trust the New Relic GPG Key
  # this step is required to tell apt that you trust the integrity of New Relic's apt repository
  gpg_key_url = "http://download.newrelic.com/#{node['newrelic']['repository']['repository_key']}.gpg"
  gpg_key_file = "#{Chef::Config[:file_cache_path]}/#{node['newrelic']['repository']['repository_key']}.gpg"

  remote_file gpg_key_file do
    source gpg_key_url
    action :create
  end

  execute 'newrelic-add-apt-key' do
    command "apt-key add #{gpg_key_file}"
  end

  # configure the New Relic apt repository
  remote_file '/etc/apt/sources.list.d/newrelic.list' do
    source 'http://download.newrelic.com/debian/newrelic.list'
    owner 'root'
    group 'root'
    mode 0644
    notifies :run, 'execute[newrelic-apt-get-update]', :immediately
    action :create_if_missing
  end

  execute 'newrelic-apt-get-update' do
    command 'apt-get update'
    action :nothing
  end
elsif platform_family?("rhel")
    if node['yum']['newrelic']['managed']
        yum_repository node['yum']['newrelic']['name'] do
          description node['yum']['newrelic']['description']
          baseurl node['yum']['newrelic']['baseurl']
          gpgcheck node['yum']['newrelic']['gpgcheck']
          gpgkey node['yum']['newrelic']['gpgkey']
          enabled node['yum']['newrelic']['enabled']
          action :create
        end
    end
end
