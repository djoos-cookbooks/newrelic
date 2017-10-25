require 'spec_helper'

describe 'newrelic_lwrp_test::agent_infrastructure' do
  before do
    stub_resources
  end

  context 'Centos' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:log_level => LOG_LEVEL, :platform => 'centos', :version => '6.8', :step_into => ['newrelic_agent_infrastructure']) do |node|
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'installs New Relic Infrastructure agent' do
      expect(chef_run).to install_newrelic_agent_infrastructure('Install')
    end

    it 'creates a yum_repository for newrelic' do
      expect(chef_run).to create_yum_repository('newrelic-infra')
    end

    it 'creates newrelic infrastructure yml config template from agent/infrastructure/newrelic.yml.erb' do
      expect(chef_run).to render_file('/etc/newrelic-infra.yml').with_content('0000ffff0000ffff0000ffff0000ffff0000ffff')
    end

    it 'installs newrelic-infra' do
      expect(chef_run).to install_package('newrelic-infra')
    end

    it 'enables newrelic-infra service' do
      expect(chef_run).to enable_service('newrelic-infra')
    end
  end
end
