require_relative 'spec_helper'

describe 'newrelic_lwrp_test::server_monitor' do
  before do
    stub_resources
  end

  ::CHECK_OPTS = {
    :log_level => LOG_LEVEL,
    :platform => 'centos',
    :version => '6.5',
    :step_into => ['newrelic_server_monitor']
  }

  context 'Any OS' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(CHECK_OPTS) do |node|
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'Installs Newrelic PHP agent' do
      expect(chef_run).to install_newrelic_server_monitor('Install')
    end

    it 'creates a yum_repository for newrelic' do
      expect(chef_run).to create_yum_repository('newrelic')
    end

    it 'installs nrsysmond' do
      expect(chef_run).to install_package('newrelic-sysmond')
    end

    it 'creates newrelic config template from nrsysmond.cfg.erb' do
      expect(chef_run).to render_file('/etc/newrelic/nrsysmond.cfg').with_content('0000ffff0000ffff0000ffff0000ffff0000ffff')
    end

    it 'enables service' do
      expect(chef_run).to_not enable_service('newrelic-sysmond')
    end
  end
end
