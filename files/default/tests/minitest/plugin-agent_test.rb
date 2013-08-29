#
# Cookbook Name:: newrelic
# Test:: plugin-agent
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

require File.expand_path('../support/helpers', __FILE__)

describe 'newrelic::plugin-agent-default' do
  include Helpers::TestHelper

  it 'installs plugin-agent' do
    file('/usr/local/bin/newrelic_plugin_agent').must_exist
  end

  it 'must set license key ' do
    file(node['newrelic']['plugin-agent']['config_file']).must_include(node['newrelic']['application_monitoring']['license'])
  end

  it 'service newrelic-plugin-agent must be enabled' do
    # we need to wait for a bit till service comes up
    cmd = shell_out('sleep 3; /etc/init.d/newrelic-plugin-agent status')
    cmd.exitstatus.to_s.must_include('0')

    service('newrelic-plugin-agent').must_be_enabled
  end
end
