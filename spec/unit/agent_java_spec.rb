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

    it 'Installs New Relic Java agent' do
      expect(chef_run).to install_newrelic_agent_java('Install')
    end

    it 'creates install_dir' do
      expect(chef_run).to create_directory('/opt/newrelic/java')
    end

    it 'creates newrelic.jar' do
      expect(chef_run).to create_remote_file('/opt/newrelic/java/newrelic.jar')
    end

    it 'creates newrelic yml config template from newrelic.yml.erb' do
      expect(chef_run).to render_file('/opt/newrelic/java/newrelic.yml').with_content('0000ffff0000ffff0000ffff0000ffff0000ffff')
    end

    it 'execute newrelic_install_newrelic.jar' do
      expect(chef_run).to run_execute('newrelic_install_newrelic.jar')
    end
  end
end
