#
# Cookbook Name:: newrelic
# Recipe:: nodejs_agent
#
# Copyright 2012-2015, Escape Studios
#

node['newrelic']['nodejs_agent']['apps'].each do |nodeapp|
  newrelic_agent_nodejs nodeapp['app_path'] do
    license NewRelic.application_monitoring_license(node)
    app_name nodeapp['app_name'] unless nodeapp['app_name'].nil?
    app_log_level nodeapp['app_log_level'] unless nodeapp['app_log_level'].nil?
    app_log_filepath nodeapp['app_log_filepath'] unless nodeapp['app_log_filepath'].nil?
    capture_params nodeapp['capture_params'] unless nodeapp['capture_params'].nil?
    ignored_params nodeapp['ignored_params'] unless nodeapp['ignored_params'].nil?
  end
end
