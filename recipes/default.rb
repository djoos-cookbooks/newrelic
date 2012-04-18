#
# Cookbook Name:: chef-newrelic
# Recipe:: default
#
# Copyright 2012, Escape Studios
#

case node[:platform]
	when "debian", "ubuntu"
		#trust the New Relic GPG Key
		#this step is required to tell apt that you trust the integrity of New Relic's apt repository
		gpg_key_id = "548C16BF"

		if gpg_key_id
			gpg_key_url = "http://download.newrelic.com/#{gpg_key_id}.gpg"

			gpg_key_already_installed = "apt-key list | grep #{gpg_key_id}"

			if gpg_key_url
				execute "wget -O - #{gpg_key_url} | apt-key add -" do
					notifies :run, "execute[apt-get-update]", :immediately
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
			mode 0640
			notifies :run, "execute[apt-get-update]", :immediately
			action :create_if_missing
		end

		#update the local package list
		execute "apt-get-update" do
			command "apt-get update"
			action :nothing
		end
end