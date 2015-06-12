#
# Cookbook Name:: newrelic
# Recipe:: agent_java
#
# Copyright 2012-2014, Escape Studios
#

require 'uri'

# include helper methods
include NewRelic::Helpers

use_inline_resources if defined?(use_inline_resources)

action :install do
  # Check license key provided
  check_license
  create_install_directory
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

def install_newrelic
  version = nil
  jar_file = nil

  if new_resource.version == 'latest'
    version = 'current'

    url_content = open('https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/') { |f| f.read.lines.grep(/jar/i).to_s }
    jar_file = url_content.split(/\W+jar/).first.to_s.split('\\"').last + '.jar'
  else
    version = new_resource.version
    jar_file = 'newrelic.jar'
  end

  https_download = "https://download.newrelic.com/newrelic/java-agent/newrelic-agent/#{version}/#{jar_file}"

  if new_resource.app_location.nil?
    app_location = new_resource.install_dir
  else
    app_location = new_resource.app_location
  end

  # If we are installing it using java, just cache the file
  if new_resource.execute_agent_action == true
    jarfile_location = "#{Chef::Config['file_cache_path']}/newrelic.jar"
  else
    jarfile_location = "#{app_location}/newrelic.jar"
  end

  remote_file jarfile_location do
    source https_download
    owner 'root'
    group 'root'
    mode 0664
    action :create
  end

  execute "newrelic_install_jar_file" do
    command "sudo java -jar #{jar_file} -s #{app_location} install"
    only_if { new_resource.execute_agent_action == true }
  end
end

def generate_agent_config
  if new_resource.app_location.nil?
    app_location = new_resource.install_dir
  else
    app_location = new_resource.app_location
  end
  template "#{app_location.install_dir}/newrelic.yml" do
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

def remove_newrelic
  if new_resource.app_location.nil?
    app_location = new_resource.install_dir
  else
    app_location = new_resource.app_location
  end
  if app_location == '/opt/newrelic/java'
    execute 'newrelic-remove-default' do
      command 'sudo rm -rf /opt/newrelic'
      only_if { ::File.exist?('/opt/newrelic/newrelic.yml') }
    end
  else
    execute 'newrelic-remove' do
      command "sudo rm -rf #{app_location}/newrelic"
      only_if { ::File.exist?("#{app_location}/newrelic/newrelic.yml") }
    end
  end
end
