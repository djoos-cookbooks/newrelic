require 'spec_helper'

describe file('/etc/php5/mods-available/newrelic.ini'), :if => %w(debian ubuntu).include?(os[:family]) do
  it { is_expected.to be_file }
end
