require 'spec_helper'
require_relative '../../libraries/newrelic'

describe 'libraries/newrelic.rb' do
  # helper to build different kinds of node objects
  def build_node(lic = nil, server = nil, app = nil)
    node = {}
    node['newrelic'] = {}

    node['newrelic']['license'] = lic if lic

    if server
      node['newrelic']['server_monitoring'] = {}
      node['newrelic']['server_monitoring']['license'] = server
    end

    if app
      node['newrelic']['application_monitoring'] = {}
      node['newrelic']['application_monitoring']['license'] = app
    end

    node
  end

  it "returns nil when node['newrelic'] is not defined" do
    license = NewRelic.license({})
    expect(license).to be(nil)
  end

  it "returns nil when node['newrelic']['license'] is not defined" do
    license = NewRelic.license(build_node)
    expect(license).to be(nil)
  end

  it "returns node['newrelic']['license'] for all licenses when main value is set" do
    node = build_node(lic = 'a')
    expect(NewRelic.license(node)).to eq('a')
    expect(NewRelic.server_monitoring_license(node)).to eq('a')
    expect(NewRelic.application_monitoring_license(node)).to eq('a')
  end

  it "returns node['newrelic']['license'] for all licenses except node['newrelic']['server_monitoring']['license']" do
    node = build_node(lic = 'a', server = 'b', app = nil)
    expect(NewRelic.license(node)).to eq('a')
    expect(NewRelic.server_monitoring_license(node)).to eq('b')
    expect(NewRelic.application_monitoring_license(node)).to eq('a')
  end

  it "returns node['newrelic']['license'] for all licenses except node['newrelic']['application_monitoring']['license']" do
    node = build_node(lic = 'a', server = nil, app = 'c')
    expect(NewRelic.license(node)).to eq('a')
    expect(NewRelic.server_monitoring_license(node)).to eq('a')
    expect(NewRelic.application_monitoring_license(node)).to eq('c')
  end

  it "returns unique node['newrelic']['license'], node['newrelic']['server_monitoring']['license'], and node['newrelic']['application_monitoring']['license']" do
    node = build_node(lic = 'a', server = 'b', app = 'c')
    expect(NewRelic.license(node)).to eq('a')
    expect(NewRelic.server_monitoring_license(node)).to eq('b')
    expect(NewRelic.application_monitoring_license(node)).to eq('c')
  end
end
