#
# Cookbook Name:: newrelic
# Provider:: deployment
#
# Copyright 2012-2013, Escape Studios
#

require 'curl'

def whyrun_supported?
    true
end

action :notify do
    if url && api_key && (app_name || application_id)
        Chef::Log.debug "notify New Relic of deployment"

        data_array = Array.new

        unless app_name.nil?
            data_array << "-d deployment[app_name]=#{app_name}"
        end

        unless application_id.nil?
            data_array << "-d deployment[application_id]=#{application_id}"
        end

        unless description.nil?
            data_array << "-d deployment[description]=#{description}"
        end

        unless revision.nil?
            data_array << "-d deployment[revision]=#{revision}"
        end

        unless changelog.nil?
            data_array << "-d deployment[changelog]=#{changelog}"
        end

        unless user.nil?
            data_array << "-d deployment[user]=#{user}"
        end

        data_string = data_array.join(' ')

        execute "newrelic-deployment-notify" do
            command "curl -H 'x-api-key:#{api_key}' #{data_string} #{url}"
            creates "/var/lib/slapd/uid.bdb"
            action :run
        end
    end
end