require 'spec_helper'

describe 'newrelic_lwrp_test::agent_java' do
  before do
    stub_resources
  end

  context 'Centos' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:log_level => LOG_LEVEL, :platform => 'centos', :version => '6.6', :step_into => ['newrelic_agent_java']) do |node|
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'Installs New Relic Java agent' do
      expect(chef_run).to install_newrelic_agent_java('Install')
    end

    it 'creates install_dir' do
      expect(chef_run).to create_directory('/opt/newrelic/java')
    end

    it 'creates newrelic-java.zip' do
      expect(chef_run).to create_remote_file('/opt/newrelic/java/newrelic.zip')
    end

    it 'sends a notification to newrelic-extract-jar after creating newrelic-java.zip' do
      expect(chef_run.remote_file('/opt/newrelic/java/newrelic.zip')).to notify('execute[newrelic-extract-jar]').immediately
    end

    it 'defines newrelic-extract-jar execute block' do
      expect(chef_run.execute('newrelic-extract-jar')).to do_nothing
    end

    it 'creates newrelic yml config template from newrelic.yml.erb' do
      expect(chef_run).to render_file('/opt/newrelic/java/newrelic.yml').with_content('0000ffff0000ffff0000ffff0000ffff0000ffff')
    end

    it 'execute newrelic_install_newrelic.zip' do
      expect(chef_run).to run_execute('newrelic_install_newrelic.jar')
    end
  end
end
