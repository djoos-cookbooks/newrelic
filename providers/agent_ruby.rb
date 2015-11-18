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
  create_install_directory
  install_newrelic
  generate_agent_config
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
  gem_package 'newrelic_rpm' do
    action :install
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
    sensitive true
    action :create
  end
end

def remove_newrelic
  execute "remove #{new_resource.install_dir}/newrelic.yml" do
    command "sudo rm #{new_resource.install_dir}/newrelic.yml"
    only_if { ::File.exist?("#{new_resource.install_dir}/newrelic.yml") }
  end
  gem_package 'newrelic_rpm' do
    action :remove
  end
end
