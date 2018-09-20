require 'spec_helper'

describe 'newrelic_lwrp_test::agent_dotnetcore' do
  before do
    stub_resources
  end

  context 'when on Windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:log_level => LOG_LEVEL, :platform => 'windows', :version => '2012', :step_into => ['newrelic_agent_dotnetcore']) do |node|
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'Installs the New Relic .Net Core Agent on Windows' do
      expect(chef_run).to install_newrelic_agent_dotnetcore('Install')
    end

    it 'Extracts the zip file to local folder' do
      expect(chef_run).to unzip_newrelic_agent('unzip source to NewRelic directory')
    end

    it 'Creates environmental Variable for Agent Home Directory' do
      expect(chef_run).to create_windows_envriomental_variable('CORECLR_NEWRELIC_HOME')
    end

    it 'Creates environmental Variable for CLR Profiler' do
      expect(chef_run).to create_windows_envriomental_variable('CORECLR_PROFILER')
    end

    it 'Creates environmental Variable for PAth to CLR Profiler' do
      expect(chef_run).to create_windows_envriomental_variable('CORECLR_PROFILER_PATH')
    end

    it 'Create newrelic.config file' do
      expect(chef_run).to render_file('C:\New Relic\newrelic-netcore20-agent\newrelic.config').with_content('0000ffff0000ffff0000ffff0000ffff0000ffff')
    end
  end

  context 'when on Debian Family' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:log_level => LOG_LEVEL, :platform => 'ubuntu', :version => '18.04', :step_into => ['newrelic_agent_dotnetcore']) do |node|
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'Installs the New Relic .Net Core Agent on Debian' do
      expect(chef_run).to install_newrelic_agent_dotnetcore('Install')
    end

    it 'Install New Relic .NET Core Agent (apt)' do
      expect(chef_run).to upgrade_apt_package('Install New Relic .Net Core Agent using apt')
    end

    it 'Creates apt repository for .Net Core Agent' do
      expect(chef_run).to add_apt_repository('newrelic')
    end

    it 'Updates the apt repositorys for .Net Core Agent' do
      expect(chef_run).to update_apt_update('update')
    end

    it 'Creates environmental Variable for Agent Home Directory' do
      expect(chef_run).to create_coreclr_newrelic_home('CORECLR_NEWRELIC_HOME')
    end

    it 'Create newrelic.config file' do
      expect(chef_run).to render_file('/usr/local/newrelic-netcore20-agent/newrelic.config').with_content('0000ffff0000ffff0000ffff0000ffff0000ffff')
    end
  end

  context 'when on RHEL family' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:log_level => LOG_LEVEL, :platform => 'redhat', :version => '7', :step_into => ['newrelic_agent_dotnetcore']) do |node|
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'Installs the New Relic .Net Core Agent on RHEL' do
      expect(chef_run).to install_newrelic_agent_dotnetcore('Install')
    end

    it 'Install New Relic .NET Core Agent (yum)' do
      expect(chef_run).to install_yum_package('newrelic-netcore20-agent')
    end

    it 'Creates yum repository for .Net Core Agent' do
      expect(chef_run).to create_yum_repository('newrelic')
    end

    it 'Creates environmental Variable for Agent Home Directory' do
      expect(chef_run).to create_coreclr_newrelic_home('CORECLR_NEWRELIC_HOME')
    end

    it 'Create newrelic.config file' do
      expect(chef_run).to render_file('/usr/local/newrelic-netcore20-agent/newrelic.config').with_content('0000ffff0000ffff0000ffff0000ffff0000ffff')
    end
  end

  context 'when on CentOS' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:log_level => LOG_LEVEL, :platform => 'centos', :version => '6.8', :step_into => ['newrelic_agent_dotnetcore']) do |node|
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'Installs the New Relic .Net Core Agent on RHEL' do
      expect(chef_run).to install_newrelic_agent_dotnetcore('Install')
    end

    it 'Install New Relic .NET Core Agent (yum)' do
      expect(chef_run).to install_yum_package('newrelic-netcore20-agent')
    end

    it 'Creates yum repository for .Net Core Agent' do
      expect(chef_run).to create_yum_repository('newrelic')
    end

    it 'Creates environmental Variable for Agent Home Directory' do
      expect(chef_run).to create_coreclr_newrelic_home('CORECLR_NEWRELIC_HOME')
    end

    it 'Create newrelic.config file' do
      expect(chef_run).to render_file('/usr/local/newrelic-netcore20-agent/newrelic.config').with_content('0000ffff0000ffff0000ffff0000ffff0000ffff')
    end
  end

  context 'when on Amazon Linux' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:log_level => LOG_LEVEL, :platform => 'amazon', :version => '2018', :step_into => ['newrelic_agent_dotnetcore']) do |node|
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'Installs the New Relic .Net Core Agent on RHEL' do
      expect(chef_run).to install_newrelic_agent_dotnetcore('Install')
    end

    it 'Install New Relic .NET Core Agent (yum)' do
      expect(chef_run).to install_yum_package('newrelic-netcore20-agent')
    end

    it 'Creates yum repository for .Net Core Agent' do
      expect(chef_run).to create_yum_repository('newrelic')
    end

    it 'Creates environmental Variable for Agent Home Directory' do
      expect(chef_run).to create_coreclr_newrelic_home('CORECLR_NEWRELIC_HOME')
    end

    it 'Create newrelic.config file' do
      expect(chef_run).to render_file('/usr/local/newrelic-netcore20-agent/newrelic.config').with_content('0000ffff0000ffff0000ffff0000ffff0000ffff')
    end
  end
end
