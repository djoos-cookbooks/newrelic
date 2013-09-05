#
# Cookbook Name:: newrelic
# Recipe:: plugin-agent-install
#
# Copyright 2012, Chris Aumann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

package 'python'
package 'python-pip'
package 'python-psycopg2'

python_pip 'newrelic-plugin-agent' do
  package_name node['newrelic']['plugin-agent']['pip_package']
  action :install
end

# create newrelic user
group node['newrelic']['plugin-agent']['group'] do
  system true
end

user node['newrelic']['plugin-agent']['owner'] do
  gid    node['newrelic']['plugin-agent']['group']
  home   '/'
  shell  '/bin/false'
  system true
end

# create config/run/log directories
[ node['newrelic']['plugin-agent']['config_file'],
  node['newrelic']['plugin-agent']['pidfile'],
  node['newrelic']['plugin-agent']['logfile'] ].each do |dir|

  directory ::File.dirname(dir) do
    owner node['newrelic']['plugin-agent']['owner']
    group node['newrelic']['plugin-agent']['group']
    mode  00755
  end
end

# deploy initscript
template '/etc/init.d/newrelic-plugin-agent' do
  mode      00755
  cookbook  'newrelic'
  source    'newrelic-plugin-agent.init.erb'
  variables config_file: node['newrelic']['plugin-agent']['config_file']
  only_if { node['platform_family'] == 'debian' }
end
