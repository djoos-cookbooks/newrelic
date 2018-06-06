require 'spec_helper'

describe yumrepo('newrelic-infra'), :if => os[:family] == 'redhat' do
  it { is_expected.to exist }
  it { is_expected.to be_enabled }
end
describe file('/etc/apt/sources.list.d/newrelic-infra.list'), :if => %w[debian ubuntu].include?(os[:family]) do
  it { is_expected.to be_file }
end
describe file('/etc/newrelic-infra.yml') do
  it { is_expected.to be_file }
  it { is_expected.to be_owned_by 'root' }
  it { is_expected.to be_mode 600 }
end
%w[newrelic-infra newrelic-infra-integrations].each do |pkg|
  describe package pkg do
    it { is_expected.to be_installed }
  end
end
