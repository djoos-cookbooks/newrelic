require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'

::LOG_LEVEL = :info

def stub_resources
  stub_command('/usr/sbin/apache2 -t').and_return(true)
  stub_command('/usr/sbin/httpd -t').and_return(true)
end

def stub_node_resources(node)
  node.set['newrelic']['license'] = '0000ffff0000ffff0000ffff0000ffff0000ffff'
end

RSpec.configure do |config|
  config.log_level = :error
  config.formatter = :documentation
  config.color     = true
end

at_exit { ChefSpec::Coverage.report! }
