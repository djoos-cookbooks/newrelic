require 'spec_helper'

describe 'newrelic_lwrp_test::agent_python' do
  before do
    stub_resources
  end

  context 'Centos' do
    let(:chef_run) do
      ChefSpec::Runner.new(:log_level => LOG_LEVEL, :platform => 'centos', :version => '6.6', :step_into => ['newrelic_agent_python']) do |node|
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'Installs New Relic Python agent' do
      expect(chef_run).to install_newrelic_agent_python('Install')
    end

    it 'creates a yum_repository for newrelic' do
      expect(chef_run).to create_yum_repository('newrelic')
    end

    it 'creates directory for newrelic' do
      expect(chef_run).to create_directory('/etc/newrelic')
    end

    it 'installs python-pip newrelic package' do
      expect(chef_run).to install_python_pip('newrelic')
    end

    it 'execute verify python agent' do
      expect(chef_run).to run_execute('newrelic-admin validate-config /etc/newrelic/newrelic.ini')
    end

    it 'creates newrelic ini config template from newrelic.ini.erb' do
      expect(chef_run).to render_file('/etc/newrelic/newrelic.ini').with_content('0000ffff0000ffff0000ffff0000ffff0000ffff')
    end
  end
end
