Description
===========

This cookbook provides an easy way to install various New Relic agents and the New Relic server monitor.

More information?
* https://newrelic.com/docs/server/new-relic-for-server-monitoring
* https://newrelic.com/docs/php/new-relic-for-php
* https://newrelic.com/docs/python/new-relic-for-python
* https://docs.newrelic.com/docs/nodejs/installing-and-maintaining-nodejs

Requirements
============

## Chef version:

Make sure you run Chef >= 0.10.0.

## Cookbooks:

This cookbook recommends on the following cookbooks:

* php
* python
* ms_dotnet4
* curl
* nodejs

### Depending on your environment, these recommended cookbooks are actual dependencies (depends):
* Installing the PHP agent? You'll need the php cookbook to be available.
* Installing the Python agent? You'll need the python cookbook to be available.
* Installing the DotNet agent? You'll need the ms_dotnet4 cookbook to be available.
* Installing the nodejs agent? You'll need the nodejs cookbook to be available.

* Want to make use of deployments? You'll need the curl cookbook to be available.

## Platforms:

* Debian
* Ubuntu
* RHEL
* CentOS
* Fedora
* Scientific
* Amazon
* Windows
* SmartOS

Attributes
==========

## default.rb:

### BASIC
* `node['newrelic']['server_monitoring']['license']` - Your New Relic license key for server monitoring purposes (usually same license key as application monitoring license)
* `node['newrelic']['application_monitoring']['license']` - Your New Relic license key for application monitoring purposes (usually same license key as server monitoring license)

### ADVANCED
* `node['newrelic']['server_monitoring']['logfile']`
* `node['newrelic']['server_monitoring']['loglevel']`
* `node['newrelic']['server_monitoring']['proxy']`
* `node['newrelic']['server_monitoring']['ssl']`
* `node['newrelic']['server_monitoring']['ssl_ca_bundle']`
* `node['newrelic']['server_monitoring']['ssl_ca_path']`
* `node['newrelic']['server_monitoring']['hostname']`
* `node['newrelic']['server_monitoring']['pidfile']`
* `node['newrelic']['server_monitoring']['collector_host']`
* `node['newrelic']['server_monitoring']['timeout']`
* `node['newrelic']['server_monitoring']['windows_version']` - the Windows version to install
* `node['newrelic']['server_monitoring']['windows64_checksum']` - checksum of the 64-bit Windows version
* `node['newrelic']['server_monitoring']['windows32_checksum']` - checksum of the 32-bit Windows version
* `node['newrelic']['application_monitoring']['enabled']`
* `node['newrelic']['application_monitoring']['logfile']`
* `node['newrelic']['application_monitoring']['loglevel']`
* `node['newrelic']['application_monitoring']['appname']`
* `node['newrelic']['application_monitoring']['daemon']['logfile']`
* `node['newrelic']['application_monitoring']['daemon']['loglevel']`
* `node['newrelic']['application_monitoring']['daemon']['port']`
* `node['newrelic']['application_monitoring']['daemon']['max_threads']`
* `node['newrelic']['application_monitoring']['daemon']['ssl']`
* `node['newrelic']['application_monitoring']['daemon']['ssl_ca_path']`
* `node['newrelic']['application_monitoring']['daemon']['ssl_ca_bundle']`
* `node['newrelic']['application_monitoring']['daemon']['proxy']`
* `node['newrelic']['application_monitoring']['daemon']['pidfile']`
* `node['newrelic']['application_monitoring']['daemon']['location']`
* `node['newrelic']['application_monitoring']['daemon']['collector_host']`
* `node['newrelic']['application_monitoring']['daemon']['dont_launch']`
* `node['newrelic']['application_monitoring']['capture_params']`
* `node['newrelic']['application_monitoring']['ignored_params']`
* `node['newrelic']['application_monitoring']['error_collector']['enable']`
* `node['newrelic']['application_monitoring']['error_collector']['record_database_errors']`
* `node['newrelic']['application_monitoring']['error_collector']['prioritize_api_errors']`
* `node['newrelic']['application_monitoring']['browser_monitoring']['auto_instrument']`
* `node['newrelic']['application_monitoring']['transaction_tracer']['enable']`
* `node['newrelic']['application_monitoring']['transaction_tracer']['threshold']`
* `node['newrelic']['application_monitoring']['transaction_tracer']['detail']`
* `node['newrelic']['application_monitoring']['transaction_tracer']['slow_sql']`
* `node['newrelic']['application_monitoring']['transaction_tracer']['stack_trace_threshold']`
* `node['newrelic']['application_monitoring']['transaction_tracer']['explain_threshold']`
* `node['newrelic']['application_monitoring']['transaction_tracer']['record_sql']`
* `node['newrelic']['application_monitoring']['transaction_tracer']['custom']`
* `node['newrelic']['application_monitoring']['framework']`
* `node['newrelic']['application_monitoring']['webtransaction']['name']['remove_trailing_path']`
* `node['newrelic']['application_monitoring']['webtransaction']['name']['functions']`
* `node['newrelic']['application_monitoring']['webtransaction']['name']['files']`

## repository.rb:
* `node['newrelic']['repository_key']` - The New Relic repository key, defaults to "548C16BF"

## php-agent.rb:
* `node['newrelic']['startup_mode']` - The newrelic-daemon startup mode ("agent"/"external"), defaults to "agent"
* `node['newrelic']['web_server']['service_name']` - The web server service name, defaults to "apache2"
* `node['newrelic']['php_recipe']` - The php recipe to include for the php agent, defaults to "php::default"

## python-agent.rb:
* `node['newrelic']['python_version']` - Defaults to "latest". Version numbers can be found at http://download.newrelic.com/python_agent/release/
* `node['newrelic']['python_recipe']` - The python recipe to include for the python agent, defaults to "python::pip"

## dotnet-agent.rb:
* `node['newrelic']['https_download']` - The URL to download the MSI installer from New Relic. Default is to pull "latest"
* `node['newrelic']['install_level']` - The install version of the .NET Agent. Default is '1' but can use '50' for a complete installation
* `node['newrelic']['dotnet_recipe']` - The dotnet recipe to include for the php agent, defaults to "ms_dotnet4"

## server-monitor.rb:
* `node['newrelic']['service_name']` - The New Relic server monitoring service name, defaults to "newrelic-sysmond"
* `node['newrelic']['config_path']` - The New Relic server monitoring config path, defaults to "/etc/newrelic"
* `node['newrelic']['config_file_group']` - The New Relic server monitoring config file group, defaults to "newrelic"

## java-agent.rb:
* `node['newrelic']['https_download']` - The url to download the jar vor the NewRelic java agent
* `node['newrelic']['jar_file']` - The name of the newrelic jar file
* `node['newrelic']['install_dir']` - The directory to install the newrelic jar and config file
* `node['newrelic']['app_user']` - The user that runs the java application that will use the New Relic java agent
* `node['newrelic']['app_group']` - The group for the app_user
* `node['newrelic']['audit_mode']` - Boolean, Log all data to and from New Relic in plain text
* `node['newrelic']['log_file_count']` - The number of log files to use
* `node['newrelic']['log_limit_in_kbytes']` - The maximum number of bytes to write to any one log file
* `node['newrelic']['log_daily']` - Override other log rolling configuration and roll the logs daily

## nodejs-agent.rb
* node['newrelic']['nodejs']['apps'] - Array of Hash describing the apps to monitor

eg.
```
[ 
   { 'app_name' => 'My Application', 'app_path' => "/path/to/app/root" }
]
```

You then need to modify your application "main" file to add the following on the first line:

```
javascript
require('newrelic');
```

Resources / Providers
=====================

The deployment LWRP sends deployment information to New Relic.

## Actions
:notify - Notify New Relic of a deployment

## Attribute parameters
api_key - Your New Relic API key
app_name - The name of the application, found in the newrelic.yml file
app_id - The ID # of the application
description - Text annotation for the deployment — notes for you
revision - The revision number from your source control system (SVN, git, etc.)
changelog - A list of changes for this deployment
user - The name of the user/process that triggered this deployment

## Example

```
newrelic_deployment "my-application" do
    api_key "abcdef"
    #app_name "my-application"
    app_id 1234567
    description "some description"
    revision "some revision"
    changelog "some changelog"
    user "chef-client"
    action :notify
end
```

Usage
=====

1)
include `recipe[newrelic]` in a run list to implicly run `recipe[newrelic:repository]` and `recipe[newrelic::server-monitor]`
- OR -
include the bits and pieces explicitly in a run list:
`recipe[newrelic::repository]`
`recipe[newrelic::server-monitor]`
`recipe[newrelic::php-agent]`
`recipe[newrelic::python-agent]`
`recipe[newrelic::dotnet]`
`recipe[newrelic::nodejs]`

2)
	change the `node['newrelic']['server_monitoring']['license']` and `node['newrelic']['application_monitoring']['license']` attributes to your New Relic license keys
	--- OR ---
	override the attributes on a higher level (http://wiki.opscode.com/display/chef/Attributes#Attributes-AttributesPrecedence)

References
==========

* [New Relic home page] (http://newrelic.com/)
* [New Relic for Server Monitoring] (https://newrelic.com/docs/server/new-relic-for-server-monitoring)
* [New Relic for PHP] (https://newrelic.com/docs/php/new-relic-for-php)
* [newrelic-daemon startup modes] (https://newrelic.com/docs/php/newrelic-daemon-startup-modes)
* [New Relic for Python] (https://newrelic.com/docs/python/new-relic-for-python)
* [New Relic for .NET] (https://newrelic.com/docs/dotnet/new-relic-for-net)
* ["newrelic" cookbook by heavywater on github] (https://github.com/heavywater/chef-newrelic)
* ["newrelic_monitoring" cookbook on community.opscode.com] (http://community.opscode.com/cookbooks/newrelic_monitoring)
* ["newrelic_monitoring" cookbook on github] (https://github.com/8thBridge/chef-newrelic-monitoring)
* a very big thanks to heavywater <darrin@heavywater.ca> for the original version of this cookbook

License and Authors
===================

Author: David Joos <david@escapestudios.com>
Author: Escape Studios Development <dev@escapestudios.com>
Copyright: 2012-2014, Escape Studios

Unless otherwise noted, all files are released under the MIT license,
possible exceptions will contain licensing information in them.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
