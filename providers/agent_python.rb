#
# Cookbook:: newrelic
# Provider:: agent_python
#
# Copyright:: (c) 2016, David Joos
#

# include helper methods
include NewRelic::Helpers

action :install do
  # Check license key provided
  check_license
  newrelic_repository
  install_python_agent
  create_config_dir
  generate_agent_config
end

action :remove do
  newrelic_python_agent = 'newrelic'

  execute 'remove_python_agent' do
    command "pip uninstall #{newrelic_python_agent}"
    only_if "pip list | grep #{newrelic_python_agent}"
  end
end

def install_python_agent
  if node['platform_family'] == 'debian' && node['platform_version'] == '20.04'
    package 'python3-pip'
  else
    package 'python-pip'
  end

  newrelic_python_agent = 'newrelic'

  execute 'install_python_agent' do
    command "pip install #{newrelic_python_agent}"
    not_if "pip list | grep #{newrelic_python_agent}"
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
      resource: new_resource
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
