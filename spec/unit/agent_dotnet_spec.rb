require 'spec_helper'

describe 'newrelic_lwrp_test::agent_dotnet' do
  before do
    stub_resources
  end

  context 'Windows' do
    let(:chef_run) do
      ChefSpec::Runner.new(:log_level => LOG_LEVEL, :platform => 'windows', :version => '2012', :step_into => ['newrelic_agent_dotnet']) do |node|
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'Installs New Relic .Net agent' do
      expect(chef_run).to install_newrelic_agent_dotnet('Install')
    end

    it 'Install New Relic .NET Agent (windows_package)' do
      expect(chef_run).to install_windows_package('Install New Relic .NET Agent')
    end
  end
end
