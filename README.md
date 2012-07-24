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
* apache2
* apache2::mod_php5
* python::pip

## Platforms:

* Ubuntu
* Debian
* RHEL
* CentOS
* Fedora

Attributes
==========

* `node['newrelic']['repository_key']` - The New Relic repository key, defaults to "548C16BF"
* `node['newrelic']['license_key']` - Your New Relic license key.
* `node['newrelic']['app_name']` - Your New Relic application name. (python agent only)

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
* [New Relic for Python] (https://newrelic.com/docs/python/new-relic-for-python)

* ["newrelic" cookbook by heavywater on github] (https://github.com/heavywater/chef-newrelic)
* ["newrelic_monitoring" cookbook on community.opscode.com] (http://community.opscode.com/cookbooks/newrelic_monitoring)
* ["newrelic_monitoring" cookbook on github] (https://github.com/8thBridge/chef-newrelic-monitoring)

* a very big thanks to heavywater <darrin@heavywater.ca> for the original version of this cookbook

CHANGELOG :
===========

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
Copyright: 2012, Escape Studios

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