#
# Cookbook Name:: newrelic
# Recipe:: nodejs_agent
#
# Copyright 2012-2014, Escape Studios
#

include_recipe 'newrelic::repository'

license = node['newrelic']['application_monitoring']['license']

# install the newrelic.js file into each projects
node['newrelic']['nodejs_agent']['apps'].each do |nodeapp|
  execute 'npm-install-nodejs_agent' do
    cwd nodeapp['app_path']
    command "npm #{node['newrelic']['nodejs_agent']['agent_action']} newrelic"
  end

  template "#{nodeapp['app_path']}/newrelic.js" do
    cookbook node['newrelic']['nodejs_agent']['template']['cookbook']
    source node['newrelic']['nodejs_agent']['template']['source']
    variables(
      :license => license,
      :app_name => nodeapp['app_name'],
      :app_log_level => 'INFO'
    )
  end
end
