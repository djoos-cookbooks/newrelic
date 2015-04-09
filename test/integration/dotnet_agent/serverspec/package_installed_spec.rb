require 'serverspec'

set :backend, :cmd
set :os, :family => 'windows'

describe package('New Relic .NET Agent (64-bit)') do
  it { should be_installed }
end
