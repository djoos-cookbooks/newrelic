#
# Cookbook Name:: newrelic
# Test:: repository-agent-default
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

describe 'newrelic::repository' do
  include Helpers::TestHelper

  it 'adds the New Relic gpg key' do
    case node[:platform]
      when "debian", "ubuntu"
        newrelic_key = shell_out("apt-key list")
        assert newrelic_key.stdout.include?(node['newrelic']['repository_key'])
    end
  end

  it 'installs the New Relic repository' do
    case node[:platform]
      when "debian", "ubuntu"
        file("/etc/apt/sources.list.d/newrelic.list").must_exist
      when "redhat", "centos", "fedora", "scientific", "amazon"
        package("newrelic-repo").must_be_installed
    end
  end
end
