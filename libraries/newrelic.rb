# NewRelic module
module NewRelic
  def self.license(node)
    node['newrelic']['license']
  end

  def self.server_monitoring_license(node)
    node['newrelic']['server_monitoring']['license'] || license(node)
  end

  def self.application_monitoring_license(node)
    node['newrelic']['application_monitoring']['license'] || license(node)
  end
end
