#
# Cookbook Name:: newrelic
# Provider:: deployment
#
# Copyright 2012-2015, Escape Studios
#

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :notify do
  key = new_resource.key

  # @todo take out deprecated api_key logic
  if new_resource.api_key && !new_resource.api_key.empty?
    Chef::Log.warn "The 'api_key'-attribute has been deprecated. Please make use of the key and key_type attributes instead."
    key = new_resource.api_key
  end

  unless key && !key.empty?
    Chef::Log.fatal "The #{key_type} is required to notify New Relic of a deployment."
  end

  if new_resource.url && (new_resource.app_name || new_resource.app_id)
    Chef::Log.debug 'notify New Relic of deployment'

    data = []

    if new_resource.key_type == 'license_key'
      data << '"x-license-key:' + key + '"'
    else
      data << '"x-api-key:' + key + '"'
    end

    if new_resource.app_name && !new_resource.app_name.empty?
      data << '-d "deployment[app_name]=' + new_resource.app_name + '"'
    end

    if new_resource.app_id && !new_resource.app_id.empty?
      data << '-d "deployment[app_id]=' + new_resource.app_id.to_s + '"'
    end

    if new_resource.description && !new_resource.description.empty?
      data << '-d "deployment[description]=' + clean(new_resource.description) + '"'
    end

    if new_resource.revision && !new_resource.revision.empty?
      data << '-d "deployment[revision]=' + new_resource.revision + '"'
    end

    if new_resource.changelog && !new_resource.changelog.empty?
      data << '-d "deployment[changelog]=' + clean(new_resource.changelog) + '"'
    end

    if new_resource.user && !new_resource.user.empty?
      data << '-d "deployment[user]=' + new_resource.user + '"'
    end

    command_curl = "curl -H #{data.join(' ')} #{new_resource.url}"

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
