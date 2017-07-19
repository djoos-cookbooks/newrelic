require 'spec_helper'

describe yumrepo('newrelic'), :if => os[:family] == 'redhat' do
  it { is_expected.to exist }
  it { is_expected.to be_enabled }
end
describe file('/etc/apt/sources.list.d/newrelic.list'), :if => %w[debian ubuntu].include?(os[:family]) do
  it { is_expected.to be_file }
end
describe package 'newrelic-daemon' do
  it { is_expected.to be_installed }
end
