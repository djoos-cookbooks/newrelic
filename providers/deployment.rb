#
# Cookbook Name:: newrelic
# Provider:: deployment
#
# Copyright 2012-2014, Escape Studios
#

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :notify do
  if new_resource.url && new_resource.api_key && (new_resource.app_name || new_resource.app_id)
    Chef::Log.debug 'notify New Relic of deployment'

    data = Array.new

    unless new_resource.app_name.nil?
      data << '-d "deployment[app_name]=' + new_resource.app_name + '"'
    end

    unless new_resource.app_id.nil?
      data << '-d "deployment[app_id]=' + new_resource.app_id.to_s + '"'
    end

    unless new_resource.description.nil?
      data << '-d "deployment[description]=' + clean(new_resource.description) + '"'
    end

    unless new_resource.revision.nil?
      data << '-d "deployment[revision]=' + new_resource.revision + '"'
    end

    unless new_resource.changelog.nil?
      data << '-d "deployment[changelog]=' + clean(new_resource.changelog) + '"'
    end

    unless new_resource.user.nil?
      data << '-d "deployment[user]=' + new_resource.user + '"'
    end

    command_curl = "curl -H 'x-api-key:#{new_resource.api_key}' #{data.join(' ')} #{new_resource.url}"

    Chef::Log.debug "curl command: #{command_curl}"

    execute 'newrelic-deployment-notify' do
      command command_curl
      action :run
    end

    new_resource.updated_by_last_action(true)
  end
end

private

def clean(string)
  string.gsub('"', '\"').gsub("'", "\'")
end
