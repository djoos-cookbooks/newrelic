# Cookbook Name:: newrelic
# Attributes:: nodejs-agent
#
# MIT Licensed

# Array of Hash describing the apps to monitor:
#   [ 
#   { 'app_name' => 'My Application', 'app_path' => "/path/to/app/root" }
#   ]
default['newrelic']['nodejs']['apps'] = []

