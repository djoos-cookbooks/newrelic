#
# Cookbook Name:: newrelic
# Provider:: agent_nodejs
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
  raise 'Cannot install newrelic nodejs agent. Missing npm. Please ensure nodejs and npm are installed before calling this resource.' unless npm_installed?
  raise "Cannot install newrelic nodejs agent. app_path #{new_resource.app_path} directory does not exist." unless directory_exists?(new_resource.app_path)
  newrelic_repository
  install_nodejs_agent
end

action :remove do
  execute 'npm-uninstall-nodejs_agent' do
    cwd new_resource.app_path
    command 'npm uninstall newrelic'
  end
end

def install_nodejs_agent
  execute 'npm-install-nodejs_agent' do
    cwd new_resource.app_path
    command "npm install newrelic@#{new_resource.version}"
  end

  template "#{new_resource.app_path}/newrelic.js" do
    cookbook new_resource.cookbook
    source new_resource.source
    variables(
      :resource => new_resource
    )
    sensitive true
  end
end

def npm_installed?
  # check if npm is installed
  cmd = Mixlib::ShellOut.new('which npm')
  cmd.run_command

  return true unless cmd.error?
  false
end
