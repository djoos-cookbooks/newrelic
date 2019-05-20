require 'spec_helper'

describe file('/etc/php5/conf.d/newrelic.ini'), :if => %w[12.04].include?(os[:release]) do
  it { is_expected.to be_file }
end

describe file('/etc/php5/mods-available/newrelic.ini'), :if => %w[14.04].include?(os[:release]) do
  it { is_expected.to be_file }
end

describe file('/etc/php/7.0/mods-available/newrelic.ini'), :if => os[:release] == '16.04' do
  it { is_expected.to be_file }
end

describe file('/etc/php.d/newrelic.ini'), :if => os[:family] == 'redhat' do
  it { is_expected.to be_file }
end

describe command('php --modules') do
  its(:stdout) { is_expected.to match(/newrelic/) }
end
