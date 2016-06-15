# Encoding: utf-8
#
# Cookbook Name:: newrelic_poc
# Recipe:: agent_docker
#
# Copyright 2012-2015, Escape Studios
#

docker_service 'default' do
  action :nothing
end

docker_installation_package 'default' do
  package_name node['docker']['package_name']
  package_version node['docker']['package_version']
  action :create
  notifies :start, "docker_service[#{node['docker']['service_name']}]", :immediately
end

include_recipe 'newrelic::docker_agent'
