require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'newrelic::default' do

  it 'installs newrelic-sysmond' do
      expect(package('newrelic-sysmond')).to be_installed
  end

end
