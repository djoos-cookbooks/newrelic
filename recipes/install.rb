#
# Cookbook Name:: newrelic
# Recipe:: install
#
# Copyright 2012, Escape Studios
#

case node[:platform]
	when "debian", "ubuntu"
		#trust the New Relic GPG Key
		#this step is required to tell apt that you trust the integrity of New Relic's apt repository
		gpg_key_id = node[:newrelic][:repository_key]

		if gpg_key_id
			gpg_key_url = "http://download.newrelic.com/#{gpg_key_id}.gpg"

			gpg_key_already_installed = "apt-key list | grep #{gpg_key_id}"

			if gpg_key_url
				execute "newrelic-add-gpg-key" do
					command "wget -O - #{gpg_key_url} | apt-key add -"
					notifies :run, "execute[newrelic-apt-get-update]", :immediately
					not_if gpg_key_already_installed
				end
			end
		end

		#configure the New Relic apt repository
		local_file = "/etc/apt/sources.list.d/newrelic.list"

		remote_file "#{local_file}" do
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
	when "redhat", "centos", "fedora"
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