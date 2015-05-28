#
# Cookbook Name:: newrelic
# Recipe:: nodejs_agent
#
# Copyright 2012-2015, Escape Studios
#

license = NewRelic.application_monitoring_license(node)

node['newrelic']['nodejs_agent']['apps'].each do |nodeapp|
  newrelic_agent_nodejs nodeapp['app_path'] do
    license license
    app_name nodeapp['app_name'] unless nodeapp['app_name'].nil?
    app_log_level nodeapp['app_log_level'] unless nodeapp['app_log_level'].nil?
    app_log_filepath nodeapp['app_log_filepath'] unless nodeapp['app_log_filepath'].nil?
  end
end
