#
# Cookbook Name:: newrelic
# Recipe:: server-monitor
#
# Copyright 2012-2013, Escape Studios
#

case node['platform']
when "debian", "ubuntu", "redhat", "centos", "fedora", "scientific", "amazon", "smartos", "suse"

  case node['platform']
  when "suse"
    # should work with bsd, osx, solaris and all
    # sorry, long and ugly. We apre probably repeating what is normally done by the package manager...

    group "newrelic" do
      action :create
    end

    tarname = 'newrelic-sysmond.tar.gz'
    sysmond_tar = "#{Chef::Config[:file_cache_path]}/#{tarname}"
    untardir = "#{Chef::Config[:file_cache_path]}/newrelic-sysmond-latest"

    tarurl = [node['newrelic']['sysmond_tar_baseurl'], node['newrelic']['sysmond_tar_version'], "linux.tar.gz"].join '-'
    pkgname = tarurl.split('/')[-1].gsub /.tar.gz/, ''

    remote_file sysmond_tar do
      source tarurl
      owner "root"
      group "root"
      mode 0644
      notifies :run, "execute[newrelic-cleanup-sysmond]", :immediately
      notifies :run, "execute[newrelic-untar-sysmond]", :immediately
      action :create_if_missing
    end

    directory untardir do
      mode 0755
      action :create
    end

    execute "newrelic-cleanup-sysmond" do
      command "rm -rf #{untardir}"
      action :nothing
      notifies :create, "directory[#{untardir}]", :immediately
    end

    execute "newrelic-untar-sysmond" do
      command "tar xfz #{sysmond_tar} -C #{untardir}"
      notifies :run, "execute[newrelic-install-sysmond]", :immediately
    end

    directory "/etc/newrelic" do
      action :create
    end

    # This stinks: we make sure not to reload on every run, but we may ends up
    # not being able to overwrite (Text file busy error) our file if it indeed changes.
    # Would need a big pile of stop-if-this-or-that resource... dammit
    log("cp #{untardir}/*/daemon/nrsysmond.#{ node['kernel']['machine'] == "x86_64" ? "x64" : "x86" } /usr/local/sbin/nrsysmond ; cp #{untardir}/*/scripts/nrsysmond-config /usr/local/sbin") { level :warn}
    execute "newrelic-install-sysmond" do
      not_if "diff -q #{untardir}/*/daemon/nrsysmond.#{ node['kernel']['machine'] == "x86_64" ? "x64" : "x86" } /usr/local/sbin/nrsysmond "
      # we use * so that we don't have to know the exact name of the tarball content
      command "cp #{untardir}/*/daemon/nrsysmond.#{ node['kernel']['machine'] == "x86_64" ? "x64" : "x86" } /usr/local/sbin/nrsysmond "
    end

    # Use template name per-platform discovery to set correctly your platform
    template "/etc/init.d/newrelic-sysmond" do
      source "newrelic-sysmond.init.erb"
      mode 0755
    end

    file "/etc/sysconfig/nrsysmond" do
      content "NRSYSMOND_CONFIG=/etc/newrelic/nrsysmond.cfg\n"
    end

    directory "/var/log/newrelic/" do
      action :create
    end
  else
    package node['newrelic']['service_name'] do
      action :install
    end
  end
  #configure your New Relic license key
  template "#{node['newrelic']['config_path']}/nrsysmond.cfg" do
    source "nrsysmond.cfg.erb"
    owner "root"
    group node['newrelic']['config_file_group']
    mode "640"
    variables(
      :license => node['newrelic']['server_monitoring']['license'],
      :logfile => node['newrelic']['server_monitoring']['logfile'],
      :loglevel => node['newrelic']['server_monitoring']['loglevel'],
      :proxy => node['newrelic']['server_monitoring']['proxy'],
      :ssl => node['newrelic']['server_monitoring']['ssl'],
      :ssl_ca_path => node['newrelic']['server_monitoring']['ssl_ca_path'],
      :ssl_ca_bundle => node['newrelic']['server_monitoring']['ssl_ca_bundle'],
      :pidfile => node['newrelic']['server_monitoring']['pidfile'],
      :collector_host => node['newrelic']['server_monitoring']['collector_host'],
      :timeout => node['newrelic']['server_monitoring']['timeout']
    )
    notifies :restart, "service[#{node['newrelic']['service_name']}]"
  end

  service node['newrelic']['service_name'] do
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:enable, :start] #starts the service if it's not running and enables it to start at system boot time
  end
when "windows"
        include_recipe node['newrelic']['dotnet_recipe']

        if node['kernel']['machine'] == "x86_64"
                windows_package "New Relic Server Monitor" do
                source "http://download.newrelic.com/windows_server_monitor/release/NewRelicServerMonitor_x64_#{node['newrelic']['server_monitoring']['windows_version']}.msi"
                options "/L*v install.log /qn NR_LICENSE_KEY=#{node['newrelic']['server_monitoring']['license']}"
                action :install
                version node['newrelic']['server_monitoring']['windows_version']
                checksum node['newrelic']['server_monitoring']['windows64_checksum']
            end
        else
            windows_package "New Relic Server Monitor" do
                source "http://download.newrelic.com/windows_server_monitor/release/NewRelicServerMonitor_x86_#{node['newrelic']['server_monitoring']['windows_version']}.msi"
                options "/L*v install.log /qn NR_LICENSE_KEY=#{node['newrelic']['server_monitoring']['license']}"
                action :install
                version node['newrelic']['server_monitoring']['windows_version']
                checksum node['newrelic']['server_monitoring']['windows32_checksum']
            end
        end

        #on Windows service creation/startup is done by the installer
end
