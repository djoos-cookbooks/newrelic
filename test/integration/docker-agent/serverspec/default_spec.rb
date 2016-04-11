require 'spec_helper'

describe package 'docker' do
  it { should be_installed }
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
