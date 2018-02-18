#
# Cookbook Name:: newrelic
# Recipe:: agent_java
#
# Copyright (c) 2016, David Joos
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
    mode '0775'
    action :create
  end
end

def agent_jar
  package 'unzip'

  version = if new_resource.version == 'latest'
              'current'
            else
              new_resource.version
            end

  filename = if new_resource.version == 'latest'
               'newrelic-java.zip'
             else
               "newrelic-java-#{new_resource.version}.zip"
             end

  cache_dir = Chef::Config[:file_cache_path]

  remote_file "#{new_resource.install_dir}/newrelic.zip" do
    source "#{new_resource.repository}/#{version}/#{filename}"
    user new_resource.app_user
    group new_resource.app_group
    mode '0664'
    action :create
    notifies :run, 'execute[newrelic-extract-jar]', :immediately
  end

  execute 'newrelic-extract-jar' do
    cwd new_resource.install_dir
    user new_resource.app_user
    group new_resource.app_group
    command 'unzip -oj newrelic.zip newrelic/newrelic.jar'
    action :nothing
  end
end

def generate_agent_config
  template "#{new_resource.install_dir}/newrelic.yml" do
    cookbook new_resource.template_cookbook
    source new_resource.template_source
    owner new_resource.app_user
    group new_resource.app_group
    mode '0644'
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
      mode '0775'
      action :create
    end
    path = ::File.dirname(path)
  end
end

def install_newrelic
  jar_file = 'newrelic.jar'
  app_location = if new_resource.app_location.nil?
                   new_resource.install_dir
                 else
                   new_resource.app_location
                 end
  execute "newrelic_install_#{jar_file}" do
    cwd new_resource.install_dir
    command "sudo java -jar newrelic.jar -s #{app_location} #{new_resource.agent_action}"
    only_if { new_resource.execute_agent_action == true }
  end
end

def remove_newrelic
  app_location = if new_resource.app_location.nil?
                   new_resource.install_dir
                 else
                   new_resource.app_location
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
