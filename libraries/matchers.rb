if defined?(ChefSpec)
  ChefSpec.define_matcher :newrelic_server_monitor
  ChefSpec.define_matcher :newrelic_agent_php
  ChefSpec.define_matcher :newrelic_agent_java
  ChefSpec.define_matcher :newrelic_agent_ruby
  ChefSpec.define_matcher :newrelic_agent_dotnet
  ChefSpec.define_matcher :newrelic_agent_python
  ChefSpec.define_matcher :newrelic_agent_nodejs

  def install_newrelic_server_monitor(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_server_monitor, :install, resource_name)
  end

  def install_newrelic_agent_php(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent_php, :install, resource_name)
  end

  def install_newrelic_agent_java(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent_java, :install, resource_name)
  end

  def install_newrelic_agent_ruby(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent_ruby, :install, resource_name)
  end

  def install_newrelic_agent_dotnet(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent_dotnet, :install, resource_name)
  end

  def install_newrelic_agent_python(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent_python, :install, resource_name)
  end

  def install_newrelic_agent_nodejs(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent_nodejs, :install, resource_name)
  end

  def remove_newrelic_server_monitor(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_server_monitor, :remove, resource_name)
  end

  def remove_newrelic_agent_php(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent_php, :remove, resource_name)
  end

  def remove_newrelic_agent_java(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent_java, :remove, resource_name)
  end

  def remove_newrelic_agent_ruby(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent_ruby, :remove, resource_name)
  end

  def remove_newrelic_agent_dotnet(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent_dotnet, :remove, resource_name)
  end

  def remove_newrelic_agent_python(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent_python, :remove, resource_name)
  end

  def remove_newrelic_agent_nodejs(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_agent_nodejs, :remove, resource_name)
  end

end
