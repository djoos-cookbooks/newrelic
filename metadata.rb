name             "newrelic"
maintainer       "Escape Studios"
maintainer_email "dev@escapestudios.com"
license          "MIT"
description      "Installs/Configures New Relic"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.1"

%w{ debian ubuntu redhat centos fedora scientific amazon windows smartos }.each do |os|
supports os
end

depends "python"

recommends "php"
recommends "ms_dotnet4"
recommends "curl"
recommends "nodejs"

recipe "newrelic", "Adds the New Relic repository, installs & configures the New Relic server monitor agent."
recipe "newrelic::repository", "Adds the New Relic repository."
recipe "newrelic::server-monitor-agent", "Installs & configures the New Relic server monitor agent."
recipe "newrelic::dotnet-agent", "Installs New Relic .NET agent"
recipe "newrelic::java-agent", "Installs the New Relic Java agent."
recipe "newrelic::nodejs-agent", "Installs New Relic Node.js agent"
recipe "newrelic::php-agent", "Installs the New Relic PHP agent."
recipe "newrelic::python-agent", "Installs the New Relic Python agent."
recipe "newrelic::ruby-agent", "Installs the New Relic Ruby agent."
recipe "newrelic::meetme-plugin", "Installs the New Relic MeetMe plugin."
