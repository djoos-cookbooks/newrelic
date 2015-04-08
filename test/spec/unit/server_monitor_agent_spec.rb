require 'spec_helper'

describe 'newrelic::server_monitor_agent' do
  context 'Ubuntu 12.04' do
    let(:chef_run) { ChefSpec::Runner.new(:platform => 'ubuntu', :version => '12.04').converge(described_recipe) }

    it 'creates newrelic config template from nrsysmond.cfg.erb' do
      expect(chef_run).to render_file("#{chef_run.node['newrelic']['server_monitor_agent']['config_path']}/nrsysmond.cfg")
    end

    it 'enables service' do
      expect(chef_run).to enable_service(chef_run.node['newrelic']['server_monitor_agent']['service_name'])
    end

    it 'starts service' do
      expect(chef_run).to start_service(chef_run.node['newrelic']['server_monitor_agent']['service_name'])
    end
  end

  context 'Debian 7' do
    let(:chef_run) { ChefSpec::Runner.new(:platform => 'debian', :version => '7.1').converge(described_recipe) }

    it 'creates newrelic config template from nrsysmond.cfg.erb' do
      expect(chef_run).to render_file("#{chef_run.node['newrelic']['server_monitor_agent']['config_path']}/nrsysmond.cfg")
    end

    it 'enables service' do
      expect(chef_run).to enable_service(chef_run.node['newrelic']['server_monitor_agent']['service_name'])
    end

    it 'starts service' do
      expect(chef_run).to start_service(chef_run.node['newrelic']['server_monitor_agent']['service_name'])
    end
  end

  context 'CentOS 6' do
    let(:chef_run) { ChefSpec::Runner.new(:platform => 'centos', :version => '6.4').converge(described_recipe) }

    it 'creates newrelic config template from nrsysmond.cfg.erb' do
      expect(chef_run).to render_file("#{chef_run.node['newrelic']['server_monitor_agent']['config_path']}/nrsysmond.cfg")
    end

    it 'enables service' do
      expect(chef_run).to enable_service(chef_run.node['newrelic']['server_monitor_agent']['service_name'])
    end

    it 'starts service' do
      expect(chef_run).to start_service(chef_run.node['newrelic']['server_monitor_agent']['service_name'])
    end
  end

  context 'RedHat 6' do
    let(:chef_run) { ChefSpec::Runner.new(:platform => 'redhat', :version => '6.3').converge(described_recipe) }

    it 'creates newrelic config template from nrsysmond.cfg.erb' do
      expect(chef_run).to render_file("#{chef_run.node['newrelic']['server_monitor_agent']['config_path']}/nrsysmond.cfg")
    end

    it 'enables service' do
      expect(chef_run).to enable_service(chef_run.node['newrelic']['server_monitor_agent']['service_name'])
    end

    it 'starts service' do
      expect(chef_run).to start_service(chef_run.node['newrelic']['server_monitor_agent']['service_name'])
    end
  end
end
