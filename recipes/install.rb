#
# Cookbook Name:: newrelic
# Recipe:: install
#
# Copyright 2012-2013, Escape Studios
#

package "wget"

case node[:platform]
    when "debian", "ubuntu"
        #trust the New Relic GPG Key
        #this step is required to tell apt that you trust the integrity of New Relic's apt repository
        gpg_key_id = node[:newrelic][:repository_key]
        gpg_key_url = "http://download.newrelic.com/#{gpg_key_id}.gpg"

        execute "newrelic-add-gpg-key" do
            command "wget -O - #{gpg_key_url} | apt-key add -"
            notifies :run, "execute[newrelic-apt-get-update]", :immediately
            not_if "apt-key list | grep #{gpg_key_id}"
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
        if node[:kernel][:machine] == "x86_64"
            machine = "x86_64"
        else
            machine = "i386"
        end

        remote_file "/tmp/newrelic-repo-5-3.noarch.rpm" do
            source "http://download.newrelic.com/pub/newrelic/el5/#{machine}/newrelic-repo-5-3.noarch.rpm"
            action :create_if_missing
        end

        package "newrelic-repo" do
            source "/tmp/newrelic-repo-5-3.noarch.rpm"
            provider Chef::Provider::Package::Rpm
            action :install
        end
end
