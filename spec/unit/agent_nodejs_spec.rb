require 'spec_helper'

describe 'newrelic_lwrp_test::agent_nodejs' do
  before do
    stub_resources
  end

  context 'Centos' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(:log_level => LOG_LEVEL, :platform => 'centos', :version => '6.6', :step_into => ['newrelic_agent_nodejs']) do |node|
        stub_resources
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'creates directory for nodejs app' do
      expect(chef_run).to create_directory('/var/mynode_app')
    end

    it 'Installs New Relic Nodejs agent' do
      expect(chef_run).to install_newrelic_agent_nodejs('/var/mynode_app')
    end

    it 'creates a yum_repository for newrelic' do
      expect(chef_run).to create_yum_repository('newrelic')
    end

    it 'creates newrelic.js config template ' do
      expect(chef_run).to render_file('/var/mynode_app/newrelic.js').with_content('0000ffff0000ffff0000ffff0000ffff0000ffff')
    end

    it 'installs newrelic npm package' do
      expect(chef_run).to run_execute('npm install newrelic')
    end
  end
end
