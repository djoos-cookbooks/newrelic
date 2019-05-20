require 'spec_helper'

describe 'newrelic_lwrp_test::agent_php' do
  before do
    stub_resources
  end

  context 'Centos' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:log_level => LOG_LEVEL, :platform => 'centos', :version => '6.8', :step_into => ['newrelic_agent_php']) do |node|
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'installs New Relic PHP agent' do
      expect(chef_run).to install_newrelic_agent_php('Install')
    end

    it 'creates a yum_repository for newrelic' do
      expect(chef_run).to create_yum_repository('newrelic')
    end

    it 'removes newrelic-php5-broken ' do
      expect(chef_run).to remove_package('newrelic-php5-broken').with(:version => '3.0.5.95')
    end

    it 'installs newrelic-php5' do
      expect(chef_run).to install_package('newrelic-php5')
    end

    it 'stub service' do
      expect(chef_run).to_not enable_service('stub_service')
    end

    it 'sends a notification to newrelic-install after installing newrelic-php5' do
      expect(chef_run.package('newrelic-php5')).to notify('execute[newrelic-install]').immediately
    end

    it 'defines newrelic-install execute block' do
      expect(chef_run.execute('newrelic-install')).to do_nothing
    end

    it 'restarts the webserver at the end of the chef run when running newrelic-install' do
      expect(chef_run.execute('newrelic-install')).to notify('service[httpd]').delayed
    end

    it 'creates newrelic ini config template from newrelic.ini.erb' do
      expect(chef_run).to render_file('/etc/php.d/newrelic.ini').with_content('0000ffff0000ffff0000ffff0000ffff0000ffff')
    end

    it 'restarts the webserver at the end of the chef run when changing the config file' do
      expect(chef_run.template('/etc/php.d/newrelic.ini')).to notify('service[httpd]').delayed
    end

    context 'with an external startup mode' do
      let(:chef_run) do
        ChefSpec::Runner.new(:log_level => LOG_LEVEL, :platform => 'centos', :version => '6.8', :step_into => ['newrelic_agent_php']) do |node|
          stub_node_resources(node)
        end.converge(described_recipe)
      end

      it 'creates newrelic config template from newrelic.conf.erb' do
        expect(chef_run).to render_file('/etc/newrelic/newrelic.cfg')
      end

      it 'restarts the webserver at the end of the chef run when changing /etc/newrelic/newrelic.cfg config file' do
        expect(chef_run.template('/etc/newrelic/newrelic.cfg')).to notify('service[httpd]').delayed
      end

      it 'restarts the newrelic-daemon when changing /etc/newrelic/newrelic.cfg config file' do
        expect(chef_run.template('/etc/newrelic/newrelic.cfg')).to notify('service[httpd]').delayed
      end

      it 'starts and enables newrelic-daemon' do
        expect(chef_run).to enable_service('newrelic-daemon')
        expect(chef_run).to start_service('newrelic-daemon')
      end
    end

    it 'defines newrelic-enable-module execute block' do
      expect(chef_run.execute('newrelic-enable-module')).to do_nothing
    end
  end
end
