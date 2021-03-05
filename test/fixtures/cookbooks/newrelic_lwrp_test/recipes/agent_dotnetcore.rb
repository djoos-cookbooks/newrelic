#
# Cookbook Name:: newrelic_lwrp_test
# Recipe:: agent_dotnetcore
#
#

newrelic_agent_dotnetcore 'Install' do
  license node['newrelic']['license']
  app_name 'My Application;Sub Application'
end
