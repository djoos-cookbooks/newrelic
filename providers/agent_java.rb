#
# Cookbook Name:: newrelic
# Recipe:: agent_java
#
# Copyright 2012-2015, Escape Studios
#

# include helper methods
include NewRelic::Helpers

use_inline_resources if defined?(use_inline_resources)

action :install do
  # Check license key provided
  check_license
  newrelic_repository
  create_install_directory
  agent_jar
  generate_agent_config
  allow_app_group_write_to_log_file_path
  install_newrelic
end

action :remove do
  remove_newrelic
end

def create_install_directory
  directory new_resource.install_dir do
    owner new_resource.app_user
    group new_resource.app_group
    recursive true
    mode 0775
    action :create
  end
end

def agent_jar
  jar_file = "newrelic-agent-#{new_resource.version}.jar"
  agent_jar = "#{new_resource.install_dir}/#{jar_file}"
  https_download = "https://download.newrelic.com/newrelic/java-agent/newrelic-agent/#{new_resource.version}/newrelic-agent-#{new_resource.version}.jar"
  remote_file jar_file do
    source https_download
    owner 'root'
    group 'root'
    mode 0664
    action :create_if_missing
  end
end

def generate_agent_config
  if new_resource.daemon_proxy.nil?
    daemon_proxy_host = nil
    daemon_proxy_port = nil
    daemon_proxy_user = nil
    daemon_proxy_password = nil
  else
    proxy = URI(new_resource.daemon_proxy)

    daemon_proxy_host = proxy.host
    daemon_proxy_port = proxy.port
    daemon_proxy_user = proxy.user
    daemon_proxy_password = proxy.password
  end

  template "#{new_resource.install_dir}/newrelic.yml" do
    cookbook new_resource.template_cookbook
    source new_resource.template_source
    owner 'root'
    group 'root'
    mode 0644
    variables(
      :resource => new_resource
    )
    action :create
  end
end

def allow_app_group_write_to_log_file_path
  path = new_resource.logfile_path
  until path.nil? || path.empty? || path == File::SEPARATOR
    directory path do
      group new_resource.app_group
      mode 0775
      action :create
    end
    path = File.dirname(path)
  end
end

# TODO: Fails on 2nd chef-client run
def install_newrelic
  jar_file = "newrelic-agent-#{new_resource.version}.jar"
  if new_resource.app_location.nil?
    app_location = new_resource.install_dir
  else
    app_location = new_resource.app_location
  end
  execute "newrelic_install_#{jar_file}" do
    command "sudo java -jar #{jar_file} -s #{app_location} install"
    only_if { new_resource.execute_agent_action == true }
  end
end

# TODO: Complete logic and testing
def remove_newrelic
  if new_resource.app_location.nil?
    app_location = new_resource.install_dir
  else
    app_location = new_resource.app_location
  end
  if app_location == '/opt/newrelic/java'
    execute 'newrelic-remove-default' do
      command 'sudo rm -rf /opt/newrelic'
    end
  else
    execute 'newrelic-remove' do
      command "sudo rm -rf #{app_location}/newrelic"
    end
  end
end
