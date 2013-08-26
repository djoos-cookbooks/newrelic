#
# Cookbook Name:: newrelic
# Test:: server-monitor
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

describe 'newrelic::server-monitor' do
  include Helpers::TestHelper

  it 'installs the New Relic system monitor' do
    package(node['newrelic']['service_name']).must_be_installed
  end

  it 'installs the New Relic system monitor config' do
    file("#{node['newrelic']['config_path']}/nrsysmond.cfg").must_exist
  end

  it 'must set license key' do
    file("#{node['newrelic']['config_path']}/nrsysmond.cfg").must_include('TESTKEY_SERVER_MONITOR')
  end

  it 'starts the New Relic system monitor' do
    # we need to wait for a bit for the service to come
    cmd = shell_out("sleep 3; service #{node['newrelic']['service_name']} status")
    cmd.exitstatus.to_s.must_include('0')

    service(node['newrelic']['service_name']).must_be_enabled
  end
end
