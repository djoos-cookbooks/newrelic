require 'spec_helper'
set :path, '/opt/rbenv/shims:/opt/rbenv/bin:/opt/rbenv/plugins/ruby_build/bin:/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:$PATH'

describe file('/opt/newrelic/ruby') do
  it { should be_directory }
end

describe package('newrelic_rpm') do
  it { should be_installed.by('gem') }
end

describe file('/opt/newrelic/ruby/newrelic.yml') do
  it { should be_file }
  its(:content) { should match('0000ffff0000ffff0000ffff0000ffff0000ffff') }
end
