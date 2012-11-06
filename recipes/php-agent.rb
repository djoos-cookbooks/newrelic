#
# Cookbook Name:: newrelic
# Recipe:: php-agent
#
# Copyright 2012, Escape Studios
#

# Execute apache2 receipe + mod_php5 receipe
include_recipe "php"
include_recipe "apache2"
include_recipe "apache2::mod_php5"

package "newrelic-php5" do
	action :upgrade
end

#run newrelic-install
execute "newrelic-install" do
	command "newrelic-install install"
	action :run
	notifies :restart, "service[apache2]", :delayed
end

service "newrelic-daemon" do
  supports :status => true, :start => true, :stop => true, :restart => true
  notifies :restart, "service[apache2]", :delayed
end

#https://newrelic.com/docs/php/newrelic-daemon-startup-modes
log "newrelic-daemon startup mode: #{node[:newrelic][:startup_mode]}"

if node[:newrelic][:startup_mode] == "agent"
	#agent startup mode

	#ensure that the daemon isn't currently running
	service "newrelic-daemon" do
		action [:disable, :stop] #stops the service if it's running and disables it from starting at system boot time
	end

	#ensure that the file /etc/newrelic/newrelic.cfg does not exist if it does, move it aside (or remove it)
    execute "newrelic-backup-cfg" do
		command "mv /etc/newrelic/newrelic.cfg /etc/newrelic/newrelic.cfg.external"
		only_if do File.exists?("/etc/newrelic/newrelic.cfg") end
    end

	#ensure that the file /etc/newrelic/upgrade_please.key does not exist if it does, move it aside (or remove it)
    execute "newrelic-backup-key" do
		command "mv /etc/newrelic/upgrade_please.key /etc/newrelic/upgrade_please.key.external"
		only_if do File.exists?("/etc/newrelic/upgrade_please.key") end
    end

	#configure New Relic INI file and set the daemon related options (documented at /usr/lib/newrelic-php5/scripts/newrelic.ini.template)
	#and restart apache in order to pick up the new settings
	template "/etc/newrelic/newrelic.ini" do
		source "newrelic.ini.php.erb"
		owner "root"
		group "root"
		mode "0644"
		variables(
			:license_key => node[:newrelic][:license_key]
		)
		action :create
		notifies :restart, "service[apache2]", :delayed
	end
else
	#external startup mode

	#configure proxy daemon settings
	template "/etc/newrelic/newrelic.cfg" do
		source "newrelic.cfg.erb"
		owner "root"
		group "root"
		mode "0644"
		action :create
	end

	service "newrelic-daemon" do
		action [:enable, :start] #starts the service if it's not running and enables it to start at system boot time
	end
end