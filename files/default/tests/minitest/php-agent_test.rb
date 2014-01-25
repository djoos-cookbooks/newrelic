#
# Cookbook Name:: newrelic
# Test:: php-agent-default
#
# Copyright 2013, Jeff Byrnes
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

require File.expand_path('../support/helpers', __FILE__)

describe 'newrelic::php-agent' do
  include Helpers::TestHelper

  it 'installs the New Relic PHP Agent' do
    package('newrelic-php5').must_be_installed
  end

  it 'stops the New Relic daemon' do
    service('newrelic-daemon').wont_be_running
  end

  it 'disables the New Relic daemon' do
    service('newrelic-daemon').wont_be_enabled
  end

  it 'removes the New Relic daemon config' do
    file("#{node['newrelic']['config_path']}/newrelic.cfg").wont_exist
  end

  it 'removes the New Relic upgrade.key' do
    file("#{node['newrelic']['config_path']}/upgrade_please.key").wont_exist
  end

  it 'installs the New Relic PHP Agent config' do
    file("#{node['php']['ext_conf_dir']}/newrelic.ini").must_exist
  end
end
