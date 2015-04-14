require 'spec_helper'

describe 'newrelic::repository' do
  # before(:each) do
  #   stub_command('apt-key list | grep 548C16BF').and_return(true)
  # end

  context 'Ubuntu 12.04' do
    let(:chef_run) { ChefSpec::Runner.new(:platform => 'ubuntu', :version => '12.04').converge(described_recipe) }

    it 'installs the New Relic apt repository' do
      expect(chef_run).to add_apt_repository('newrelic').with(
        :uri          => 'http://download.newrelic.com/debian/',
        :distribution => 'newrelic',
        :components   => ['non-free'],
        :key          => 'http://download.newrelic.com/548C16BF.gpg'
      )
    end
  end

  context 'Debian 7' do
    let(:chef_run) { ChefSpec::Runner.new(:platform => 'debian', :version => '7.1').converge(described_recipe) }

    it 'installs the New Relic apt repository' do
      expect(chef_run).to add_apt_repository('newrelic').with(
        :uri          => 'http://download.newrelic.com/debian/',
        :distribution => 'newrelic',
        :components   => ['non-free'],
        :key          => 'http://download.newrelic.com/548C16BF.gpg'
      )
    end
  end

  context 'CentOS 6' do
    let(:chef_run) { ChefSpec::Runner.new(:platform => 'centos', :version => '6.4').converge(described_recipe) }

    it 'installs the New Relic yum repository' do
      expect(chef_run).to create_yum_repository('newrelic').with(
        :description => 'New Relic packages for Enterprise Linux 5 - $basearch',
        :baseurl => 'http://download.newrelic.com/pub/newrelic/el5/$basearch/',
        :gpgkey => 'http://download.newrelic.com/548C16BF.gpg'
      )
    end
  end

  context 'RedHat 6' do
    let(:chef_run) { ChefSpec::Runner.new(:platform => 'redhat', :version => '6.3').converge(described_recipe) }

    it 'installs the New Relic yum repository' do
      expect(chef_run).to create_yum_repository('newrelic').with(
        :description => 'New Relic packages for Enterprise Linux 5 - $basearch',
        :baseurl => 'http://download.newrelic.com/pub/newrelic/el5/$basearch/',
        :gpgkey => 'http://download.newrelic.com/548C16BF.gpg'
      )
    end
  end
end
