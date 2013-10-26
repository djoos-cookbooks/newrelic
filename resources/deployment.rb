#
# Cookbook Name:: newrelic
# Resource:: deployment
#
# Copyright 2012-2013, Escape Studios
#

actions :notify
default_action :notify

attribute :url, :kind_of => String, :default => "https://rpm.newrelic.com/deployments.xml"
attribute :api_key, :kind_of => String, :default => nil

attribute :app_name, :kind_of => String, :default => nil #required (if application_id is not set)
attribute :application_id, :kind_of => Integer, :default => nil #required (if app_name is not set)
attribute :description, :kind_of => String, :default => nil #optional
attribute :revision, :kind_of => String, :default => nil #optional
attribute :changelog, :kind_of => String, :default => nil #optional
attribute :user, :kind_of => String, :default => nil #optional