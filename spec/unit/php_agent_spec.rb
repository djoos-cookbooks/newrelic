require 'spec_helper'

describe 'newrelic::php_agent' do

  context 'Default config' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['newrelic']['php_agent']['config_file'] = '/etc/php5/conf.d/newrelic.ini'
      end.converge described_recipe
    end

    it 'defines the php5enmod_newrelic resource' do
      template = chef_run.template chef_run.node['newrelic']['php_agent']['config_file']
      expect(template).not_to notify 'bash[php5enmod_newrelic]'
    end

    context 'enable_php5_mod true' do
      let(:chef_run) do
        ChefSpec::Runner.new do |node|
          node.set['newrelic']['php_agent']['config_file']     = '/etc/php5/mods-available/newrelic.ini'
          node.set['newrelic']['php_agent']['enable_php5_mod'] = true
        end.converge described_recipe
      end

      it 'runs the php5enmod_newrelic resource' do
        template = chef_run.template chef_run.node['newrelic']['php_agent']['config_file']
        expect(template).to notify('bash[php5enmod_newrelic]').to(:run).immediately
      end
    end
  end

end
