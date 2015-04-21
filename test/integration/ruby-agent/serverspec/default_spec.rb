require 'spec_helper'

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
