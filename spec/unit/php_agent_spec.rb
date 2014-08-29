require 'spec_helper'

describe 'newrelic::php_agent' do
  context 'Any OS' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['newrelic']['php_agent']['config_file'] = '/etc/newrelic/newrelic.ini'
        node.set['newrelic']['php_agent']['web_server']['service_name'] = false
        node.set['newrelic']['php_agent']['startup_mode'] = 'external'
      end.converge(described_recipe)
    end

    it 'includes the newrelic::repository recipe' do
      expect(chef_run).to include_recipe('newrelic::repository')
    end

    it 'removes newrelic-php5-broken ' do
      expect(chef_run).to remove_package('newrelic-php5-broken').with(:version => '3.0.5.95')
    end

    it 'installs newrelic-php5' do
      expect(chef_run).to install_package('newrelic-php5')
    end

    it 'sends a notification  to newrelic-install after installing newrelic-php5' do
      expect(chef_run.package('newrelic-php5')).to notify('execute[newrelic-install]').immediately
    end

    it 'defines newrelic-install execute block' do
      pending('not yet supported by chefspec')
      # expect(chef_run).to define_execute('newrelic-install install')
    end

    it 'creates newrelic ini config template from newrelic.ini.erb' do
      expect(chef_run).to render_file("#{chef_run.node['newrelic']['php_agent']['config_file']}")
    end

    it 'creates newrelic config template from newrelic.conf.erb' do
      expect(chef_run).to render_file('/etc/newrelic/newrelic.cfg')
    end

  end
  context 'Ubuntu 12.04' do
    # Expected on Ubuntu 12.04 only
    # let(:chef_run) { ChefSpec::Runner.new(:platform => 'ubuntu', :version => '12.04').converge(described_recipe) }
  end

  context 'Debian 7' do
    # Expected on Debian 7 only
    # let(:chef_run) { ChefSpec::Runner.new(:platform => 'debian', :version => '7.1').converge(described_recipe) }
  end

  context 'CentOS 6' do
    # Expected on CentOS 6 only
    # let(:chef_run) { ChefSpec::Runner.new(:platform => 'centos', :version => '6.4').converge(described_recipe) }
  end

  context 'RedHat 6' do
    # Expected on RedHat 6 only
    # let(:chef_run) { ChefSpec::Runner.new(:platform => 'redhat', :version => '6.3').converge(described_recipe) }
  end
end
