require 'spec_helper'

describe file('/opt/newrelic/java') do
  it { should be_directory }
end

describe file('/newrelic-agent-3.9.0.jar') do
  it { should be_file }
end

describe file('/opt/newrelic/java/newrelic.yml') do
  it { should be_file }
  its(:content) { should match('0000ffff0000ffff0000ffff0000ffff0000ffff') }
end
