require 'spec_helper'

describe yumrepo('newrelic'), :if => os[:family] == 'redhat' do
  it { is_expected.to exist }
  it { is_expected.to be_enabled }
end
describe file('/etc/apt/sources.list.d/newrelic.list'), :if => %w[debian ubuntu].include?(os[:family]) do
  it { is_expected.to be_file }
end

describe command('cd /var/mynode_app/ && npm ls') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/newrelic@/) }
end

describe file('/var/mynode_app//newrelic.js') do
  its(:content) { should match(/license_key: '0000ffff0000ffff0000ffff0000ffff0000ffff',/) }
  its(:content) { should match(/app_name: \['my_nodejs_app'\],/) }
  its(:content) { should match(/level: 'debug',/) }
  its(:content) { should match(%r{filepath: '/var/mynode_app/mylog.log'}) }
end
