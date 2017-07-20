require 'spec_helper'

describe 'newrelic_lwrp_test::agent_ruby' do
  before do
    stub_resources
  end

  context 'Centos' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:log_level => LOG_LEVEL, :platform => 'centos', :version => '6.8', :step_into => ['newrelic_agent_ruby']) do |node|
        stub_node_resources(node)
      end.converge(described_recipe)
    end

    it 'Installs New Relic Ruby agent' do
      expect(chef_run).to install_newrelic_agent_ruby('Install')
    end

    it 'creates install_dir' do
      expect(chef_run).to create_directory('/opt/newrelic/ruby')
    end

    it 'installs a gem_package newrelic_rpm' do
      expect(chef_run).to install_gem_package('newrelic_rpm')
    end

    it 'creates newrelic yml config template from newrelic.yml.erb' do
      expect(chef_run).to render_file('/opt/newrelic/ruby/newrelic.yml').with_content('0000ffff0000ffff0000ffff0000ffff0000ffff')
    end

    it 'installs rubygems from yum' do
      expect(chef_run).to install_package('rubygems')
    end
  end
end
