#
# Cookbook Name:: newrelic
# Recipe:: agent_java
#
# Copyright 2012-2014, Escape Studios
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

# rubocop:disable AbcSize
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
# rubocop:enable AbcSize

# rubocop:disable AbcSize
def generate_agent_config
  # Proxy host config??

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
# rubocop:enable AbcSize

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

def install_newrelic
  jar_file = "newrelic-agent-#{new_resource.version}.jar"
  app_location = new_resource.install_dir
  execute "newrelic_install_#{jar_file}" do
    command "sudo java -jar #{jar_file} -s #{app_location} install"
    only_if { new_resource.execute_agent_action == true }
  end
end

def remove_newrelic
  jar_file = "newrelic-agent-#{new_resource.version}.jar"
  app_location = new_resource.install_dir
  execute 'newrelic-remove' do
    command "sudo java -jar #{jar_file} -s #{app_location} remove"
  end
end
