#
# Cookbook Name:: newrelic
# Recipe:: nodejs-agent
#
# Copyright 2012-2014, Escape Studios
#

include_recipe 'newrelic::repository'
include_recipe node['newrelic']['nodejs-agent']['nodejs_recipe']

license = node['newrelic']['application_monitoring']['license']

# install the newrelic.js file into each projects
node['newrelic']['nodejs-agent']['apps'].each do |nodeapp|
  execute 'npm-install-nodejs-agent' do
    cwd nodeapp['app_path']
    command 'npm install newrelic'
  end

  template "#{nodeapp['app_path']}/newrelic.js" do
    source 'agent/nodejs/newrelic.js.erb'
    variables(
      :license => license,
      :app_name => nodeapp['app_name'],
      :app_log_level => 'INFO'
    )
  end
end
