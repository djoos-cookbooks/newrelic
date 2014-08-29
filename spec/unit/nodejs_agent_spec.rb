require 'spec_helper'

describe 'newrelic::nodejs_agent' do
  context 'Any OS' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['newrelic']['nodejs_agent']['apps'] = [{ 'app_name' => 'My Application', 'app_path' => '/tmp/' }]
      end.converge(described_recipe)
    end

    it 'includes the newrelic::repository recipe' do
      expect(chef_run).to include_recipe('newrelic::repository')
    end

    it 'install newrelic npm package' do
      expect(chef_run).to run_execute("npm #{chef_run.node['newrelic']['nodejs_agent']['agent_action']} newrelic")
    end

    it 'creates newrelic javascript config template from newrelic.js' do
      expect(chef_run).to render_file("#{chef_run.node['newrelic']['nodejs_agent']['apps'].first['app_path']}/newrelic.js")
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
