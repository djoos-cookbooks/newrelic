# NewRelic module
module NewRelic
  def self.license(node)
    node['newrelic'] && node['newrelic']['license']
  end

  def self.server_monitoring_license(node)
    node['newrelic'] && node['newrelic']['server_monitoring'] && node['newrelic']['server_monitoring']['license'] || license(node)
  end

  def self.application_monitoring_license(node)
    node['newrelic'] && node['newrelic']['application_monitoring'] && node['newrelic']['application_monitoring']['license'] || license(node)
  end

  def self.to_string_from_boolean(variable)
    if variable.nil?
      nil
    elsif variable.is_a?(TrueClass)
      'true'
    elsif variable.is_a?(FalseClass)
      'false'
    else
      variable
    end
  end
end
