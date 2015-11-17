require 'spec_helper'

describe file('/etc/php5/apache2/conf.d/20-newrelic.ini'), :if => %w(debian ubuntu).include?(os[:family]) do
  it { is_expected.to be_file }
  it { is_expected.to be_symlink }
  it { is_expected.to be_linked_to '../../mods-available/newrelic.ini' }
end
