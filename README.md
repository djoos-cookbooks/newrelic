Description
===========

This cookbook provides an easy way to install the New Relic PHP agent and the New Relic server monitor.

More information?
* https://newrelic.com/docs/server/new-relic-for-server-monitoring
* https://newrelic.com/docs/php/new-relic-for-php
* https://newrelic.com/docs/python/new-relic-for-python

Requirements
============

## Cookbooks:

This cookbook has dependencies on the following cookbooks:

* php
* python::pip
* ms_dotnet4

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

## python-agent.rb:
* `node['newrelic']['python_version']` - Defaults to "latest". Version numbers can be found at http://download.newrelic.com/python_agent/release/

## dotnet.rb:
* `node['newrelic']['https_download']` - The URL to download the MSI installer from New Relic. Default is to pull "latest"
* `node['newrelic']['install_level']` - The install version of the .NET Agent. Default is '1' but can use '50' for a complete installation

## server-monitor.rb:
* `node['newrelic']['service_name']` - The New Relic server monitoring service name, defaults to "newrelic-sysmond"
* `node['newrelic']['config_path']` - The New Relic server monitoring config path, defaults to "/etc/newrelic"
* `node['newrelic']['config_file_group']` - The New Relic server monitoring config file group, defaults to "newrelic"

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

2)
	change the `node['newrelic']['license']` attribute to your New Relic license key
	--- OR ---
	override the attribute on a higher level (http://wiki.opscode.com/display/chef/Attributes#Attributes-AttributesPrecedence)

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
Copyright: 2012-2013, Escape Studios

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
