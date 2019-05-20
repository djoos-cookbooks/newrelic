require 'spec_helper'

describe file('/opt/tomcat_java_test_app/newrelic.jar') do
  it { is_expected.to exist }
end
