#
# Cookbook Name:: newrelic
# Provider:: deployment
#
# Copyright 2012-2013, Escape Studios
#

def whyrun_supported?
    true
end

action :notify do
    if new_resource.url && new_resource.api_key && (new_resource.application_name || new_resource.application_id)
        Chef::Log.debug "notify New Relic of deployment"

        data_array = Array.new

        unless new_resource.application_name.nil?
            data_array << "-d deployment[app_name]=#{new_resource.application_name}"
        end

        unless new_resource.application_id.nil?
            data_array << "-d deployment[application_id]=#{new_resource.application_id}"
        end

        unless new_resource.description.nil?
            data_array << "-d deployment[description]=#{new_resource.description}"
        end

        unless new_resource.revision.nil?
            data_array << "-d deployment[revision]=#{new_resource.revision}"
        end

        unless new_resource.changelog.nil?
            data_array << "-d deployment[changelog]=#{new_resource.changelog}"
        end

        unless new_resource.user.nil?
            data_array << "-d deployment[user]=#{new_resource.user}"
        end

        data_string = data_array.join(' ')

        execute "newrelic-deployment-notify" do
            command "curl -H 'x-api-key:#{api_key}' #{data_string} #{new_resource.url}"
            action :run
        end
    end
end