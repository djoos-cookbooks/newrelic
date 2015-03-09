if defined?(ChefSpec)
  def install_newrelic_agent(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent, :install, resource_name)
  end

  def install_newrelic_agent_php(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent_php, :install, resource_name)
  end

  def remove_newrelic_agent(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent, :remove, resource_name)
  end

  def remove_newrelic_agent_php(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent_php, :remove, resource_name)
  end
end
