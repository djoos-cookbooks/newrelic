#
# Cookbook Name:: newrelic
# Recipe:: agent_ruby
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
  install_newrelic
  generate_agent_config
end

action :remove do
  newrelic_remove
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
  gem_package 'newrelic_rpm' do
    action :install
  end
end

def generate_agent_config
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

def newrelic_remove
  gem_package 'newrelic_rpm' do
    action :remove
  end
end
