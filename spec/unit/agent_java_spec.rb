require 'spec_helper'

describe 'newrelic_lwrp_test::agent_java' do
  before do
    stub_resources
  end

  context 'Centos' do
    let(:chef_run) do
      ChefSpec::Runner.new(:log_level => LOG_LEVEL, :platform => 'centos', :version => '6.6', :step_into => ['newrelic_agent_java']) do |node|
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'creates a yum_repository for newrelic' do
      expect(chef_run).to create_yum_repository('newrelic')
    end
  end
end
