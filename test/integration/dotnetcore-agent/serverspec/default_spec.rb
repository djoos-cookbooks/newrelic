require 'spec_helper'

describe yumrepo('newrelic'), :if => %w[redhat amazon centos].include?(os[:family]) do
  it { is_expected.to exist }
  it { is_expected.to be_enabled }
end

describe file('/etc/apt/sources.list.d/newrelic.list'), :if => %w[debian ubuntu].include?(os[:family]) do
  it { is_expected.to be_file }
end

describe yumrepo('newrelic'), :if => os[:family] == 'centos' do
  it { is_expected.to exist }
  it { is_expected.to be_enabled }
end

describe file('/usr/local/newrelic-netcore20-agent'), :if => %w[debian ubuntu redhat centos amazon].include?(os[:family]) do
  it { is_expected.to exist }
  it { is_expected.to be_a_directory }
end

describe file('/usr/local/newrelic-netcore20-agent/newrelic.config'), :if => %w[debian ubuntu redhat centos amazon].include?(os[:family]) do
  it { is_expected.to exist }
  it { is_expected.to be_a_file }
  its(:content) { is_expected.to include('0000ffff0000ffff0000ffff0000ffff0000ffff'[]) }
end

describe file('/etc/profile.d/CORECLR_NEWRELIC_HOME.sh') do
  it { is_expected.to exist }
  it { is_expected.to be_a_file }
  its(:content) { is_expected.to include('export CORECLR_NEWRELIC_HOME="/usr/local/newrelic-netcore20-agent"') }
end
