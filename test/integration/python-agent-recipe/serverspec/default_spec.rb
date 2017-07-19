require 'spec_helper'

describe yumrepo('newrelic'), :if => os[:family] == 'redhat' do
  it { is_expected.to exist }
  it { is_expected.to be_enabled }
end

describe file('/etc/apt/sources.list.d/newrelic.list'), :if => %w[debian ubuntu].include?(os[:family]) do
  it { is_expected.to be_file }
end

describe command('pip show newrelic') do
  its(:exit_status) { should eq 0 }
end

describe file('/etc/newrelic/newrelic.ini') do
  its(:content) { should match(/license_key = 0000ffff0000ffff0000ffff0000ffff0000ffff/) }
  its(:content) { should match(/app_name = My Python Application/) }
  its(:content) { should match(/high_security: false/) }
  its(:content) { should match(/monitor_mode = true/) }
  its(:content) { should match(/log_level = info/) }
  its(:content) { should match(%r{log_file = /tmp/newrelic-python-agent.log}) }
  its(:content) { should match(/ssl = true/) }
  its(:content) { should match(/capture_params = false/) }
  its(:content) { should match(/transaction_tracer.enabled = true/) }
  its(:content) { should match(/transaction_tracer.transaction_threshold = apdex_f/) }
  its(:content) { should match(/transaction_tracer.record_sql = obfuscated/) }
  its(:content) { should match(/transaction_tracer.stack_trace_threshold = 0.5/) }
  its(:content) { should match(/transaction_tracer.explain_enabled = true/) }
  its(:content) { should match(/transaction_tracer.explain_threshold = 0.5/) }
  its(:content) { should match(/thread_profiler.enabled = true/) }
  its(:content) { should match(/error_collector.enabled = false/) }
  its(:content) { should match(/browser_monitoring.auto_instrument = true/) }
  its(:content) { should match(/cross_application_tracer.enabled = false/) }
end
