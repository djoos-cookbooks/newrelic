require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'

::LOG_LEVEL = :info

def stub_resources
  stub_command('/usr/sbin/apache2 -t').and_return(true)
  stub_command('/usr/sbin/httpd -t').and_return(true)
  shellout = double('shellout')
  shellout.stub(:run_command)
  shellout.stub(:error?)
  Mixlib::ShellOut.stub(:new).with('which npm').and_return(shellout)
  allow(File).to receive(:exist?).and_call_original
  allow(File).to receive(:exist?).with('/var/mynode_app').and_return(true)
end

def stub_node_resources(node)
  node.set['newrelic']['license'] = '0000ffff0000ffff0000ffff0000ffff0000ffff'
  node.set['newrelic']['php_agent']['web_server']['service_name'] = 'httpd'
  node.set['newrelic']['php_agent']['php_config'] = '/etc/php.d/newrelic.ini'
  node.set['rubygems'] = 'rubygems'
end

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  config.log_level = :error
  config.formatter = :documentation
  config.color     = true
end

at_exit { ChefSpec::Coverage.report! }
