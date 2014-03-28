require 'chefspec'
require 'chefspec/berkshelf'


describe 'newrelic::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge('newrelic::default') }

  it 'includes the `repository` recipe' do
    expect(chef_run).to include_recipe('newrelic::repository')
  end
  it 'includes the `server-monitor-agent` recipe' do
    expect(chef_run).to include_recipe('newrelic::server-monitor-agent')
  end
  
  it 'does not include the `dotnet-agent` recipe' do
    expect(chef_run).to_not include_recipe('newrelic::dotnet-agent')
  end
  it 'does not include the `java-agent` recipe' do
    expect(chef_run).to_not include_recipe('newrelic::java-agent')
  end
  it 'does not include the `meetme-agent` recipe' do
    expect(chef_run).to_not include_recipe('newrelic::meetme-agent')
  end
  it 'does not include the `nodejs-agent` recipe' do
    expect(chef_run).to_not include_recipe('newrelic::nodejs-agent')
  end
  it 'does not include the `php-agent` recipe' do
    expect(chef_run).to_not include_recipe('newrelic::php-agent')
  end
  it 'does not include the `python-agent` recipe' do
    expect(chef_run).to_not include_recipe('newrelic::python-agent')
  end
  it 'does not include the `ruby-agent` recipe' do
    expect(chef_run).to_not include_recipe('newrelic::ruby-agent')
  end
end
