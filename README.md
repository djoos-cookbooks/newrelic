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

## Platforms:

* Debian
* Ubuntu
* RHEL
* CentOS
* Fedora
* Scientific
* Amazon

Attributes
==========

## default.rb:

### BASIC
* `node['newrelic']['server_monitoring']['license']` - Your New Relic license key for server monitoring purposes (usually same license key as application monitoring license)
* `node['newrelic']['application_monitoring']['license']` - Your New Relic license key for server monitoring purposes (usually same license key as server monitoring license)

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

## install.rb:
* `node['newrelic']['repository_key']` - The New Relic repository key, defaults to "548C16BF"

## php-agent.rb:
* `node['newrelic']['startup_mode']` - The newrelic-daemon startup mode ("agent"/"external"), defaults to "agent"
* `node['newrelic']['web_server']['service_name']` - The web server service name, defaults to "apache2"

## python-agent.rb:
* `node['newrelic']['python_version']` - Defaults to "latest". Version numbers can be found at http://download.newrelic.com/python_agent/release/

Usage
=====

1)
include `recipe[newrelic]` in a run list to implicly run `recipe[newrelic::install]` and `recipe[newrelic::server-monitor]`
- OR -
include the bits and pieces explicitly in a run list:
`recipe[newrelic::install]`
`recipe[newrelic::server-monitor]`
`recipe[newrelic::php-agent]`
`recipe[newrelic::python-agent]`

2)
	change the `node['newrelic']['license_key']` attribute to your New Relic license key
	--- OR ---
	override the attribute on a higher level (http://wiki.opscode.com/display/chef/Attributes#Attributes-AttributesPrecedence)

References
==========

* [New Relic home page] (http://newrelic.com/)
* [New Relic for Server Monitoring] (https://newrelic.com/docs/server/new-relic-for-server-monitoring)
* [New Relic for PHP] (https://newrelic.com/docs/php/new-relic-for-php)
* [newrelic-daemon startup modes] (https://newrelic.com/docs/php/newrelic-daemon-startup-modes)
* [New Relic for Python] (https://newrelic.com/docs/python/new-relic-for-python)
* ["newrelic" cookbook by heavywater on github] (https://github.com/heavywater/chef-newrelic)
* ["newrelic_monitoring" cookbook on community.opscode.com] (http://community.opscode.com/cookbooks/newrelic_monitoring)
* ["newrelic_monitoring" cookbook on github] (https://github.com/8thBridge/chef-newrelic-monitoring)
* a very big thanks to heavywater <darrin@heavywater.ca> for the original version of this cookbook

Changelog
=========

### 0.4.7
    * splitting up attributes into recipe-specific files

### 0.4.6
    * refactoring

### 0.4.5
    * metadata-changes: name & recipe attribute(s)

### 0.4.4
    * don't unnecessarily install or trigger web server restarts
    * attributes-cleanup

### 0.4.3
    * update copyrights
    * remove apache2-dependency by making cookbook web server and php process manager 'agnostic'

### 0.4.2
    * recommend dependencies (Darrin Eden)
    * install wget dependency (Darrin Eden)

### 0.4.1
    * add support for amazon

### 0.4.0
    * add support for scientific linux (Aaron Jensen)
    * advanced configuration (newrelic.ini, nrsysmond.cfg & newrelic.cfg) via attributes

### 0.3.7
    * Use a template to configure the server-monitor instead of the non-idempotent execute (Chris Griego)
    * PHP agent 3.0 (http://blog.newrelic.com/2012/10/23/new-relic-launches-php-agent-3-0-includes-multi-tenancy-support/)
    * PHP agent newrelic-daemon startup modes: agent (new default) / external (historical default)
    * Renamed newrelic.python.erb template to newrelic.ini.python.erb

### 0.3.6
    * Added attribute to specify python version. Versions can be found at http://download.newrelic.com/python_agent/release/

### 0.3.5
	* Fixed missing license_key from newrelic.python.erb
    * Cleanup of README

### 0.3.4
    * New python agent installation (Paul Rossman)
    * New newrelic.python.erb
    * New `node['newrelic']['app_name']` attribute
    * Added apache2, php, python depends to metadata.db
    * Modified php-agent.php to use services

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
