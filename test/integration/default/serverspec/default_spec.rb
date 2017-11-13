require 'spec_helper'

describe 'newrelic::default' do
  describe package 'newrelic-sysmond' do
    it { is_expected.to_not be_installed }
  end
end
