require 'spec_helper'

describe package 'docker' do
  it { should be_installed }
end
describe yumrepo('newrelic'), :if => os[:family] == 'redhat' do
  it { is_expected.to exist }
  it { is_expected.to be_enabled }
end
describe command('yum info newrelic-sysmond'), :if => os[:family] == 'redhat' do
  its(:stdout) { should contain('From repo   : newrelic') }
end
describe file('/etc/yum.repos.d/newrelic.repo'), :if => os[:family] == 'redhat' do
  it { should exist }
  it { should contain 'baseurl=http://artifactory.gannettdigital.com/artifactory/yum-newrelic/' }
end
describe file('/etc/apt/sources.list.d/newrelic.list'), :if => %w(debian ubuntu).include?(os[:family]) do
  it { is_expected.to be_file }
end
describe package 'newrelic-sysmond' do
  it { should be_installed }
end
describe group('docker') do
  it { should exist }
end
describe user('newrelic') do
  it { should exist }
  it { should belong_to_group 'docker' }
end
describe service('docker') do
  it { should be_running }
  it { should be_enabled }
end
describe service('newrelic-sysmond') do
  it { should be_running }
  it { should be_enabled }
end
