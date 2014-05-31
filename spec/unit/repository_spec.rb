require 'spec_helper'

describe 'newrelic::repository' do
  before(:each) do
    stub_command('apt-key list | grep 548C16BF').and_return(true)
  end

  context 'Ubuntu 12.04' do
    let(:chef_run) { ChefSpec::Runner.new(:platform => 'ubuntu', :version => '12.04').converge(described_recipe) }

    it 'downloads the gpg key file' do
      expect(chef_run).to create_remote_file("#{Chef::Config[:file_cache_path]}/#{chef_run.node['newrelic']['repository']['repository_key']}.gpg")
    end

    it 'runs "apt-key add"' do
      expect(chef_run).to run_execute("apt-key add #{Chef::Config[:file_cache_path]}/#{chef_run.node['newrelic']['repository']['repository_key']}.gpg")
    end

    it 'downloads the newrelic sources file' do
      expect(chef_run).to create_remote_file_if_missing('/etc/apt/sources.list.d/newrelic.list')
    end

    it 'runs "apt-get update"' do
      resource = chef_run.remote_file('/etc/apt/sources.list.d/newrelic.list')
      expect(resource).to notify 'execute[apt-get update]'
    end
  end

  context 'Debian 7' do
    let(:chef_run) { ChefSpec::Runner.new(:platform => 'debian', :version => '7.1').converge(described_recipe) }

    it 'downloads the gpg key file' do
      expect(chef_run).to create_remote_file("#{Chef::Config[:file_cache_path]}/#{chef_run.node['newrelic']['repository']['repository_key']}.gpg")
    end

    it 'runs "apt-key add"' do
      expect(chef_run).to run_execute("apt-key add #{Chef::Config[:file_cache_path]}/#{chef_run.node['newrelic']['repository']['repository_key']}.gpg")
    end

    it 'downloads the newrelic sources file' do
      expect(chef_run).to create_remote_file_if_missing('/etc/apt/sources.list.d/newrelic.list')
    end

    it 'runs "apt-get update"' do
      resource = chef_run.remote_file('/etc/apt/sources.list.d/newrelic.list')
      expect(resource).to notify 'execute[apt-get update]'
    end
  end

  context 'CentOS 6' do
    let(:chef_run) { ChefSpec::Runner.new(:platform => 'centos', :version => '6.4').converge(described_recipe) }

    it 'downloads the newrelic rpm' do
      expect(chef_run).to create_remote_file_if_missing(Chef::Config[:file_cache_path] + '/newrelic-repo-5-3.noarch.rpm')
    end

    it 'installs the "newrelic-repo" package' do
      expect(chef_run).to install_package('newrelic-repo')
    end
  end

  context 'RedHat 6' do
    let(:chef_run) { ChefSpec::Runner.new(:platform => 'redhat', :version => '6.3').converge(described_recipe) }

    it 'downloads the newrelic rpm' do
      expect(chef_run).to create_remote_file_if_missing(Chef::Config[:file_cache_path] + '/newrelic-repo-5-3.noarch.rpm')
    end

    it 'installs the "newrelic-repo" package' do
      expect(chef_run).to install_package('newrelic-repo')
    end
  end
end
