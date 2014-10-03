require 'spec_helper'

describe 'newrelic::php_agent' do
  context 'Any OS' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['newrelic']['php_agent']['config_file'] = '/etc/newrelic/newrelic.ini'

        # see stub_service in php_agent-recipe for more information
        node.set['newrelic']['php_agent']['web_server']['service_name'] = 'stub_service'
      end.converge(described_recipe)
    end

    it 'includes the newrelic::repository recipe' do
      expect(chef_run).to include_recipe('newrelic::repository')
    end

    it 'removes newrelic-php5-broken ' do
      expect(chef_run).to remove_package('newrelic-php5-broken').with(:version => '3.0.5.95')
    end

    it 'installs newrelic-php5' do
      expect(chef_run).to install_package('newrelic-php5')
    end

    it 'sends a notification to newrelic-install after installing newrelic-php5' do
      expect(chef_run.package('newrelic-php5')).to notify('execute[newrelic-install]').immediately
    end

    it 'defines newrelic-install execute block' do
      expect(chef_run.execute('newrelic-install')).to do_nothing
    end

    it 'restarts the webserver at the end of the chef run when running newrelic-install' do
      expect(chef_run.execute('newrelic-install')).to notify("service[#{chef_run.node['newrelic']['php_agent']['web_server']['service_name']}]").delayed
    end

    it 'creates newrelic ini config template from newrelic.ini.erb' do
      expect(chef_run).to render_file("#{chef_run.node['newrelic']['php_agent']['config_file']}")
    end

    it 'restarts the webserver at the end of the chef run when changing the config file' do
      expect(chef_run.template("#{chef_run.node['newrelic']['php_agent']['config_file']}")).to notify("service[#{chef_run.node['newrelic']['php_agent']['web_server']['service_name']}]").delayed
    end

    it 'logs the startup mode' do
      expect(chef_run).to write_log("newrelic-daemon startup mode: #{chef_run.node['newrelic']['php_agent']['startup_mode']}").with(:level => :info)
    end

    context 'with an external startup mode' do
      let(:chef_run) do
        ChefSpec::Runner.new do |node|
          node.set['newrelic']['php_agent']['config_file'] = '/etc/newrelic/newrelic.ini'
          node.set['newrelic']['php_agent']['startup_mode'] = 'external'

          # see stub_service in php_agent-recipe for more information
          node.set['newrelic']['php_agent']['web_server']['service_name'] = 'stub_service'
        end.converge(described_recipe)
      end

      it 'creates newrelic config template from newrelic.conf.erb' do
        expect(chef_run).to render_file('/etc/newrelic/newrelic.cfg')
      end

      it 'restarts the webserver at the end of the chef run when changing /etc/newrelic/newrelic.cfg config file' do
        expect(chef_run.template('/etc/newrelic/newrelic.cfg')).to notify("service[#{chef_run.node['newrelic']['php_agent']['web_server']['service_name']}]").delayed
      end

      it 'restarts the newrelic-daemon when changing /etc/newrelic/newrelic.cfg config file' do
        expect(chef_run.template('/etc/newrelic/newrelic.cfg')).to notify("service[#{chef_run.node['newrelic']['php_agent']['web_server']['service_name']}]").delayed
      end

      it 'starts and enables newrelic-daemon' do
        expect(chef_run).to enable_service('newrelic-daemon')
        expect(chef_run).to start_service('newrelic-daemon')
      end
    end

    context 'with an agent startup mode' do
      let(:chef_run) do
        ChefSpec::Runner.new do |node|
          node.set['newrelic']['php_agent']['config_file'] = '/etc/newrelic/newrelic.ini'
          node.set['newrelic']['php_agent']['startup_mode'] = 'agent'

          # see stub_service in php_agent-recipe for more information
          node.set['newrelic']['php_agent']['web_server']['service_name'] = 'stub_service'
        end.converge(described_recipe)
      end

      it 'stops and disables newrelic-daemon' do
        expect(chef_run).to disable_service('newrelic-daemon')
        expect(chef_run).to stop_service('newrelic-daemon')
      end

      it 'ensure that the file /etc/newrelic/newrelic.cfg does not exist' do
        pending('we cannot test it because we can\'t stub File::exist?')
        # https://github.com/sethvargo/chefspec/issues/250
        # expect(chef_run).to run_execute('mv /etc/newrelic/newrelic.cfg /etc/newrelic/newrelic.cfg.external')
      end

      it 'ensure that the file /etc/newrelic/upgrade_please.key does not exist' do
        pending('we cannot test it because we can\'t stub File::exist?')
        # https://github.com/sethvargo/chefspec/issues/250
        # expect(chef_run).to run_execute('mv /etc/newrelic/upgrade_please.key /etc/newrelic/upgrade_please.key.external')
      end
    end

    it 'defines newrelic-php5enmod execute block' do
      expect(chef_run.execute('newrelic-php5enmod')).to do_nothing
    end

    context 'with execute php5enmod' do
      let(:chef_run) do
        ChefSpec::Runner.new do |node|
          node.set['newrelic']['php_agent']['config_file'] = '/etc/php5/mods-available/newrelic.ini'
          node.set['newrelic']['php_agent']['execute_php5enmod'] = true

          # see stub_service in php_agent-recipe for more information
          node.set['newrelic']['php_agent']['web_server']['service_name'] = 'stub_service'
        end.converge described_recipe
      end

      it 'notifies newrelic-phpenmod' do
        template = chef_run.template chef_run.node['newrelic']['php_agent']['config_file']
        expect(template).to notify('execute[newrelic-php5enmod]').to(:run).immediately
      end
    end

  end
  context 'Ubuntu 12.04' do
    # Expected on Ubuntu 12.04 only
    # let(:chef_run) { ChefSpec::Runner.new(:platform => 'ubuntu', :version => '12.04').converge(described_recipe) }
  end

  context 'Debian 7' do
    # Expected on Debian 7 only
    # let(:chef_run) { ChefSpec::Runner.new(:platform => 'debian', :version => '7.1').converge(described_recipe) }
  end

  context 'CentOS 6' do
    # Expected on CentOS 6 only
    # let(:chef_run) { ChefSpec::Runner.new(:platform => 'centos', :version => '6.4').converge(described_recipe) }
  end

  context 'RedHat 6' do
    # Expected on RedHat 6 only
    # let(:chef_run) { ChefSpec::Runner.new(:platform => 'redhat', :version => '6.3').converge(described_recipe) }
  end
end
