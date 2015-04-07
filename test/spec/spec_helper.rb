require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.log_level = :error
  config.formatter = :documentation
  config.color     = true
end

at_exit { ChefSpec::Coverage.report! }
