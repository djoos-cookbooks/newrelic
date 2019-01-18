#
# Cookbook Name:: newrelic
# Provider:: agent_python
#
# Copyright (c) 2016, David Joos
#

# rubocop:disable Style/MixinUsage
# include helper methods
include NewRelic::Helpers
# rubocop:enable Style/MixinUsage

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :install do
  # Check license key provided
  check_license
  newrelic_repository
  install_python_agent
  create_config_dir
  generate_agent_config
end

action :remove do
  python_package 'newrelic' do
    virtualenv new_resource.virtualenv if new_resource.virtualenv
    version new_resource.version if new_resource.version
    python new_resource.python if new_resource.python
    action :remove
  end
end

def install_python_agent
  python_package 'newrelic' do
    virtualenv new_resource.virtualenv if new_resource.virtualenv
    version new_resource.version if new_resource.version
    python new_resource.python if new_resource.python
    action :install
  end
end

def generate_agent_config
  template new_resource.config_file do
    cookbook new_resource.cookbook
    source new_resource.source
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      :resource => new_resource
    )
    sensitive true
    action :create
  end
end

def create_config_dir
  dir = ::File.dirname(new_resource.config_file)
  directory dir do
    owner 'root'
    group 'root'
    recursive true
  end
end
