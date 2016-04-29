require 'spec_helper'

describe 'newrelic_lwrp_test::agent_docker' do
  before do
    stub_resources
  end

  context 'Centos' do
    let(:chef_run) do
      ChefSpec::Runner.new(:log_level => LOG_LEVEL, :platform => 'centos', :version => '7.1.1503', :step_into => ['newrelic::docker_agent']) do |node|
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'Includes the newrelic::server_monitor_agent recipe' do
      expect(chef_run).to include_recipe('newrelic::server_monitor_agent')
    end

    it 'Installs New Relic agent' do
      expect(chef_run).to install_newrelic_server_monitor('Install')
    end

    it 'creates docker group with newrelic user' do
      expect(chef_run).to create_group('docker').with(:members => ['newrelic'])
    end
  end
end
