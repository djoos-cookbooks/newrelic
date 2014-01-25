#
# Cookbook Name:: newrelic
# Recipe:: nodejs-agent
#
# Copyright 2014, La Presse
# MIT License
#


include_recipe "nodejs::npm"


# Install the newrelic.js file into each projects
node['newrelic']['nodejs']['apps'].each do |nodeapp|
  execute "npm-install-nodejs-agent" do
    #not_if ""
    # creates 
    cwd nodeapp['app_path']
    command "npm install newrelic"
  end
  template "#{nodeapp['app_path']}/newrelic.js" do
    source "newrelic.js.erb"
    variables :app_name => nodeapp['app_name'], :app_log_level => "INFO"
  end
end
