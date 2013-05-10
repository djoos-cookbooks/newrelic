#
# Cookbook Name:: newrelic
# Recipe:: install
#
# Copyright 2012-2013, Escape Studios
#

node.from_file(run_context.resolve_attribute("newrelic", "install"))
case node['platform']
    when "debian", "ubuntu"
      apt_repository "newrelic" do
        uri "http://apt.newrelic.com/debian/"
        components ["newrelic", "non-free"]
        key "http://download.newrelic.com/#{node['newrelic']['repository_key']}.gpg"
        action :add
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
