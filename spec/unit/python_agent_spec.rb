require 'spec_helper'

describe 'newrelic::python_agent' do
  context 'Any OS' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'includes the newrelic::repository recipe' do
      expect(chef_run).to include_recipe('newrelic::repository')
    end

    it 'install newrelic python package' do
      expect(chef_run).to install_python_pip('newrelic')
    end

    it 'creates newrelic ini config template from newrelic.ini.erb' do
      expect(chef_run).to render_file("#{chef_run.node['newrelic']['python_agent']['config_file']}")
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
