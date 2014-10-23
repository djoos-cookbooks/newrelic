[![Build Status](https://travis-ci.org/escapestudios-cookbooks/newrelic.png)](https://travis-ci.org/escapestudios-cookbooks/newrelic)

Description
===========

This cookbook provides an easy way to install various New Relic agents and the New Relic server monitor.

More information?
* https://docs.newrelic.com/docs/server/new-relic-for-server-monitoring
* https://docs.newrelic.com/docs/php/new-relic-for-php
* https://docs.newrelic.com/docs/python/new-relic-for-python
* https://docs.newrelic.com/docs/dotnet/new-relic-for-net
* https://docs.newrelic.com/docs/java/new-relic-for-java
* https://docs.newrelic.com/docs/nodejs/installing-and-maintaining-nodejs
* https://docs.newrelic.com/docs/ruby/new-relic-for-ruby

Requirements
============

## Chef version:

Make sure you run Chef >= 0.10.0.

## Cookbooks:

* python

This cookbook recommends on the following cookbooks:

* curl (when making use of the deployment LWRP)

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
* `node['newrelic']['license']` - Your New Relic license key. Default is `nil`
* `node['newrelic']['server_monitoring']['license']` - Your New Relic license key for server monitoring purposes (defaults to value of node['newrelic']['license'])
* `node['newrelic']['application_monitoring']['license']` - Your New Relic license key for application monitoring purposes (defaults to value of node['newrelic']['license'])

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

* `node['newrelic']['application_monitoring']['enabled']`
* `node['newrelic']['application_monitoring']['logfile']`
* `node['newrelic']['application_monitoring']['logfile_path']`
* `node['newrelic']['application_monitoring']['loglevel']`
* `node['newrelic']['application_monitoring']['app_name']`
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
* `node['newrelic']['application_monitoring']['cross_application_tracer']['enable']` - Implemented for Java, PHP, Python and Ruby

## repository.rb:
* `node['newrelic']['repository']['repository_key']` - The New Relic repository key, defaults to "548C16BF"
* `node['newrelic']['repository']['repository_action']` - Repository action, defaults to :install

## php_agent.rb:
* `node['newrelic']['php_agent']['agent_action']` - Agent action, defaults to :install
* `node['newrelic']['php_agent']['install_silently']` - Determine whether to run the install in silent mode, defaults to false
* `node['newrelic']['php_agent']['startup_mode']` - The newrelic-daemon startup mode ("agent"/"external"), defaults to "agent"
* `node['newrelic']['php_agent']['web_server']['service_name']` - The web server service name, defaults to "apache2"
* `node['newrelic']['php_agent']['config_file']` - The New Relic php agent config file, depends on your php external configuration directory; eg. /etc/php5/conf.d/newrelic.ini or /etc/php5/mods-available/newrelic.ini
* `node['newrelic']['php_agent']['execute_php5enmod']` - Executes "php5enmod newrelic" if true. Needed if you use the mods-available directory, defaults to false
* `node['newrelic']['php_agent']['template']['cookbook_ini']` - Sets cookbook for .ini template, defaults to 'newrelic'
* `node['newrelic']['php_agent']['template']['source_ini']` - Sets source for .ini template, defaults to 'agent/php/newrelic.ini.erb'
* `node['newrelic']['php_agent']['template']['cookbook']` - Sets cookbook for template, defaults to 'newrelic'
* `node['newrelic']['php_agent']['template']['source']` - Sets source for template, defaults to 'agent/php/newrelic.cfg.erb'

## python_agent.rb:
* `node['newrelic']['python_agent']['agent_action']` - Agent action, defaults to :install
* `node['newrelic']['python_agent']['python_version']` - Defaults to "latest". Version numbers can be found at http://download.newrelic.com/python_agent/release/
* `node['newrelic']['python_agent']['python_venv']` - Virtual environment, default to nil
* `node['newrelic']['python_agent']['config_file']` - The New Relic python agent config file, defaults to "/etc/newrelic/newrelic.ini"
* `node['newrelic']['python_agent']['template']['cookbook']` - Sets cookbook for template, defaults to 'newrelic'
* `node['newrelic']['python_agent']['template']['source']` - Sets source for template, defaults to 'agent/python/newrelic.ini.erb'

## dotnet_agent.rb:
* `node['newrelic']['dotnet_agent']['https_download']` - The URL to download the MSI installer from New Relic. Default is to pull "latest"
* `node['newrelic']['dotnet_agent']['install_level']` - The install version of the .NET Agent. Default is '1' but can use '50' for a complete installation
* `node['newrelic']['dotnet_agent']['agent_action']` - Agent action, defaults to :install

## server_monitor_agent.rb:
* `node['newrelic']['server_monitor_agent']['service_name']` - The New Relic server monitoring service name, defaults to "newrelic-sysmond"
* `node['newrelic']['server_monitor_agent']['service_notify_action']` - The New Relic server monitoring notify action, defaults to ":restart"
* `node['newrelic']['server_monitor_agent']['service_actions']` - The New Relic server monitoring service actions, defaults to "[:enable, :start]" (#starts the service if it's not running and enables it to start at system boot time)
* `node['newrelic']['server_monitor_agent']['config_path']` - The New Relic server monitoring config path, defaults to "/etc/newrelic"
* `node['newrelic']['server_monitor_agent']['config_file_group']` - The New Relic server monitoring config file group, defaults to "newrelic"
* `node['newrelic']['server_monitor_agent']['windows_version']` - the Windows version to install, defaults to "2.0.0.198"
* `node['newrelic']['server_monitor_agent']['windows64_checksum']` - checksum of the 64-bit Windows version, defaults to "5a8f3f5e8f15997463430401756d377c321c8899c2790ca85e5587a5b643651e"
* `node['newrelic']['server_monitor_agent']['windows32_checksum']` - checksum of the 32-bit Windows version, defaults to "ac2b65eecaad461fdd2e4386e3e4c9f96ea940b35bdf7a8c532c21dbd1c99ff0"
* `node['newrelic']['server_monitor_agent']['template']['cookbook']` - Sets cookbook for template, defaults to 'newrelic'
* `node['newrelic']['server_monitor_agent']['template']['source']` - Sets source for template, defaults to 'agent/server_monitor/nrsysmond.cfg.erb'

## java_agent.rb:
* `node['newrelic']['java_agent']['https_download']` - The url to download the jar vor the New Relic Java agent
* `node['newrelic']['java_agent']['jar_file']` - The name of the newrelic jar file
* `node['newrelic']['java_agent']['install_dir']` - The directory to install the newrelic jar and config file
* `node['newrelic']['java_agent']['app_user']` - The user that runs the Java application that will use the New Relic Java agent
* `node['newrelic']['java_agent']['app_group']` - The group for the app_user
* `node['newrelic']['java_agent']['audit_mode']` - Boolean, log all data to and from New Relic in plain text
* `node['newrelic']['java_agent']['log_file_count']` - The number of log files to use
* `node['newrelic']['java_agent']['log_limit_in_kbytes']` - The maximum number of bytes to write to any one log file
* `node['newrelic']['java_agent']['log_daily']` - Override other log rolling configuration and roll the logs daily
* `node['newrelic']['java_agent']['agent_action']` - Agent action, defaults to :install
* `node['newrelic']['java_agent']['execute_agent_action']` - Execute the agent action or not, defaults to true
* `node['newrelic']['java_agent']['app_location']` - Application's location, defaults to `node['newrelic']['java_agent']['install_dir']`
* `node['newrelic']['java_agent']['template']['cookbook']` - Sets cookbook for template, defaults to 'newrelic'
* `node['newrelic']['java_agent']['template']['source']` - Sets source for template, defaults to 'agent/newrelic.yml.erb'

## nodejs_agent.rb
* `node['newrelic']['nodejs_agent']['agent_action']` - Agent action, defaults to :install
* `node['newrelic']['nodejs_agent']['apps']` - Array of Hash describing the apps to monitor

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

* `node['newrelic']['nodejs_agent']['template']['cookbook']` - Sets cookbook for template, defaults to 'newrelic'
* `node['newrelic']['nodejs_agent']['template']['source']` - Sets source for template, defaults to 'agent/nodejs/newrelic.js.erb'

## ruby_agent.rb:
* `node['newrelic']['ruby_agent']['agent_action']` - Agent action, defaults to :install
* `node['newrelic']['ruby_agent']['install_dir']` - The directory to for the config file
* `node['newrelic']['ruby_agent']['app_user']` - The user that runs the Ruby application that will use the New Relic Ruby agent
* `node['newrelic']['ruby_agent']['app_group']` - The group for the app_user
* `node['newrelic']['ruby_agent']['audit_mode']` - Boolean, log all data to and from New Relic in plain text
* `node['newrelic']['ruby_agent']['log_file_count']` - The number of log files to use
* `node['newrelic']['ruby_agent']['log_limit_in_kbytes']` - The maximum number of bytes to write to any one log file
* `node['newrelic']['ruby_agent']['log_daily']` - Override other log rolling configuration and roll the logs daily
* `node['newrelic']['ruby_agent']['template']['cookbook']` - Sets cookbook for template, defaults to 'newrelic'
* `node['newrelic']['ruby_agent']['template']['source']` - Sets source for template, defaults to 'agent/newrelic.yml.erb'

MeetMe plugin
=============

To make sure the cookbook is focussed on getting New Relic server and application monitoring, no plugin logic is provided here.
The New Relic MeetMe plugin-logic is still available, in a separate cookbook: (newrelic_meetme_plugin)[https://github.com/escapestudios-cookbooks/newrelic_meetme_plugin].

Resources / Providers
=====================

This cookbook includes an LWRP for notifying New Relic of a deployment

### `newrelic_deployment`

#### Actions
- :notify: Notify New Relic of a deployment

#### Attribute parameters
- key_type: Your New Relic API key type (api_key or license_key, defaults to api_key currently for backwards compatibility)
- key: Your New Relic key (see key_type for more information on what value to provide here exactly)
- app_name: The name of the application, found in the newrelic.yml file
- app_id: The ID # of the application
- description: Text annotation for the deployment (notes for you)
- revision: The revision number from your source control system (SVN, git, etc.)
- changelog: A list of changes for this deployment
- user: The name of the user/process that triggered this deployment

#### Example(s)
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

This cookbook includes an LWRP for generating the newrelic.yml configuration file in a specific path, which can be used to generate multiple configurations when deploying multiple different applications

### `newrelic_yml`

### Actions
- :generate - Generate the newrelic.yml config file (unique and default action)

### Example usage - Java agent

1. Install the Java Agent: add the newrelic::java_agent recipe to your run list. A newrelic.yml will be generated but not linked to anything.
2. In your application cookbook, generate the newrelic.yml for this application:

```ruby
newrelicyml="#{my_app_path}/newrelic.yml"
newrelic_yml newrelicyml do
  agent_type 'java'
  app_name 'my-super-duper-application'
end
```

3. Configure your app for newrelic using your config file and newrelic.jar:

```bash
 java -Dnewrelic.config.file=#{newrelicyml}  -javaagent:#{node['newrelic']['install_dir']}/newrelic.jar [rest of your args]
```

Usage
=====

1. include `recipe[newrelic]` in a run list to implicly run `recipe[newrelic::server_monitor_agent]`
--- OR ---
include the bits and pieces explicitly in a run list:
```ruby
`recipe[newrelic::repository]`
`recipe[newrelic::server_monitor_agent]`
`recipe[newrelic::dotnet_agent]`
`recipe[newrelic::java_agent]`
`recipe[newrelic::nodejs_agent]`
`recipe[newrelic::php_agent]`
`recipe[newrelic::python_agent]`
`recipe[newrelic::ruby_agent]`
```

2. change the `node['newrelic']['license']` attribute to your New Relic license keys
--- OR ---
override the attributes on a higher level (http://wiki.opscode.com/display/chef/Attributes#Attributes-AttributesPrecedence)

References
==========

* [New Relic home page] (http://newrelic.com/)
* [New Relic for Server Monitoring] (https://docs.newrelic.com/docs/server/new-relic-for-server-monitoring)
* [New Relic for PHP] (https://docs.newrelic.com/docs/php/new-relic-for-php)
* [newrelic-daemon startup modes] (https://newrelic.com/docs/php/newrelic-daemon-startup-modes)
* [New Relic for Python] (https://docs.newrelic.com/docs/python/new-relic-for-python)
* [New Relic for .NET] (https://docs.newrelic.com/docs/dotnet/new-relic-for-net)
* [New Relic for Java] (https://docs.newrelic.com/docs/java/new-relic-for-java)
* ["newrelic" cookbook by heavywater on github] (https://github.com/heavywater/chef-newrelic)
* ["newrelic_monitoring" cookbook on community.opscode.com] (http://community.opscode.com/cookbooks/newrelic_monitoring)
* ["newrelic_monitoring" cookbook on github] (https://github.com/8thBridge/chef-newrelic-monitoring)
* a very big thanks to heavywater <darrin@heavywater.ca> for the original version of this cookbook

License and Authors
===================

Author: David Joos <david.joos@escapestudios.com>
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
