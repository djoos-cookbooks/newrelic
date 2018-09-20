require 'spec_helper'

describe 'newrelic::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }
  ## Removed test becasue default recipie no longer installs server agent
  # it 'includes the server_monitor_agent recipe' do
  #   expect(chef_run).to include_recipe('newrelic::server_monitor_agent')
  # end
end
