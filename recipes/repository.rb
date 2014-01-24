#
# Cookbook Name:: newrelic
# Recipe:: repository
#
# Copyright 2012-2013, Escape Studios
#

case node['platform']
    when "debian", "ubuntu", "redhat", "centos", "fedora", "scientific", "amazon"
        package "wget"
end

case node['platform']
    when "debian", "ubuntu"
        #trust the New Relic GPG Key
        #this step is required to tell apt that you trust the integrity of New Relic's apt repository
        gpg_key_id = node['newrelic']['repository_key']
        gpg_key_url = "http://download.newrelic.com/#{gpg_key_id}.gpg"
        gpg_key_file = "#{Chef::Config['file_cache_path']}/newrelic-gpg-key"

        remote_file gpg_key_file do
            action :create_if_missing
            not_if "apt-key list | grep #{gpg_key_id}"
            source gpg_key_url
            notifies :run, "execute[newrelic-add-apt-key]", :immediately
        end

        execute "newrelic-add-apt-key" do
            command "apt-key add #{gpg_key_file}"
            action :nothing
            notifies :run, "execute[newrelic-apt-get-update]", :immediately
        end

        #configure the New Relic apt repository
        remote_file "/etc/apt/sources.list.d/newrelic.list" do
            source "http://download.newrelic.com/debian/newrelic.list"
            owner "root"
            group "root"
            mode 0644
            notifies :run, "execute[newrelic-apt-get-update]", :immediately
            action :create_if_missing
        end

        #update the local package list
        execute "newrelic-apt-get-update" do
            command "apt-get update"
            action :nothing
        end
    when "redhat", "centos", "fedora", "scientific", "amazon"
        #install the newrelic-repo package, which configures a new package repository for yum
        if node['kernel']['machine'] == "x86_64"
            machine = "x86_64"
        else
            machine = "i386"
        end

        remote_file "#{Chef::Config['file_cache_path'] || '/tmp'}/newrelic-repo-5-3.noarch.rpm" do
            source "http://download.newrelic.com/pub/newrelic/el5/#{machine}/newrelic-repo-5-3.noarch.rpm"
            action :create_if_missing
        end

        package "newrelic-repo" do
            source "#{Chef::Config['file_cache_path'] || '/tmp'}/newrelic-repo-5-3.noarch.rpm"
            provider Chef::Provider::Package::Rpm
            action :install
        end
end
