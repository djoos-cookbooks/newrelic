#
# Cookbook:: newrelic
# Provider:: yml
#
# Copyright:: (c) 2016, David Joos
#

require 'uri'

action :generate do
  template new_resource.yml_path do
    cookbook new_resource.template_cookbook
    source new_resource.template_source
    owner new_resource.owner
    group new_resource.group
    mode '0644'
    variables(
      resource: new_resource
    )
    sensitive true
    action :create
  end
end
