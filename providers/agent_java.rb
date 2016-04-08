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
  version = nil
  jar_file = nil

  if new_resource.version == 'latest'
    version = 'current'

    url_content = open('https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/') { |f| f.read.lines.grep(/jar/i).to_s }
    jar_file = url_content.split(/\W+jar/).first.to_s.split('\\"').last + '.jar'
  else
    version = new_resource.version
    jar_file = "newrelic-agent-#{version}.jar"
  end

  https_download = "https://download.newrelic.com/newrelic/java-agent/newrelic-agent/#{version}/#{jar_file}"

  remote_file "#{new_resource.install_dir}/newrelic.jar" do
    source https_download
    owner new_resource.app_user
    group new_resource.app_group
    mode 0664
    action :create
  end
end

def generate_agent_config
  template "#{new_resource.install_dir}/newrelic.yml" do
    cookbook new_resource.template_cookbook
    source new_resource.template_source
    owner new_resource.app_user
    group new_resource.app_group
    mode 0644
    variables(
      :resource => new_resource
    )
    sensitive true
    action :create
  end
end

def allow_app_group_write_to_log_file_path
  path = new_resource.logfile_path
  until path.nil? || path.empty? || path == ::File::SEPARATOR
    directory path do
      group new_resource.app_group
      mode 0775
      action :create
    end
    path = ::File.dirname(path)
  end
end

def install_newrelic
  jar_file = 'newrelic.jar'
  if new_resource.app_location.nil?
    app_location = new_resource.install_dir
  else
    app_location = new_resource.app_location
  end
  execute "newrelic_install_#{jar_file}" do
    cwd new_resource.install_dir
    command "sudo java -jar newrelic.jar -s #{app_location} install"
    only_if { new_resource.execute_agent_action == true }
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
