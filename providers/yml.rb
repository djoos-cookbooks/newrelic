#
# Cookbook Name:: newrelic
# Provider:: yml
#
# Copyright 2012-2015, Escape Studios
#

require 'uri'

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :generate do
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

  t = template new_resource.yml_path do
    cookbook new_resource.template_cookbook
    source new_resource.template_source
    owner new_resource.owner
    group new_resource.group
    mode 0644
    variables(
      :resource => new_resource
    )
    sensitive true
    action :create
  end

  new_resource.updated_by_last_action(t.updated_by_last_action?)
end
