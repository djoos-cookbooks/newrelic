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
  Mixlib::ShellOut.stub(:new).with('php -r "echo PHP_MAJOR_VERSION;"').and_return(double('shell_out', :run_command => nil, :error! => nil, :stdout => '5'))
  Mixlib::ShellOut.stub(:new).with('php -r "echo PHP_MINOR_VERSION;"').and_return(double('shell_out', :run_command => nil, :error! => nil, :stdout => '6'))
  allow(File).to receive(:exist?).and_call_original
  allow(File).to receive(:exist?).with('/var/mynode_app').and_return(true)
end

def stub_node_resources(node)
  node.override['newrelic']['license'] = '0000ffff0000ffff0000ffff0000ffff0000ffff'
  node.override['newrelic']['php_agent']['web_server']['service_name'] = 'httpd'
  node.override['newrelic']['php_agent']['php_config'] = '/etc/php.d/newrelic.ini'
  node.override['rubygems'] = 'rubygems'
end

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = %i[should expect]
  end
  config.log_level = :error
  config.formatter = :documentation
  config.color     = true
end

at_exit { ChefSpec::Coverage.report! }
