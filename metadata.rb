name             "newrelic"
maintainer       "Escape Studios"
maintainer_email "dev@escapestudios.com"
license          "MIT"
description      "Installs/Configures New Relic"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.6.0"

%w{ debian ubuntu redhat centos fedora scientific amazon windows smartos }.each do |os|
supports os
end

depends "chef-vault"
depends "python"
depends "apt"
depends "yum", "~> 3.0"

recommends "php"
recommends "ms_dotnet4"
recommends "curl"
recommends "nodejs"

recipe "newrelic", "Adds the New Relic repository, installs & configures the New Relic server monitor package."
recipe "newrelic::repository", "Adds the New Relic repository."
recipe "newrelic::server-monitor", "Installs & configures the New Relic server monitor package."
recipe "newrelic::dotnet-agent", "Installs New Relic .NET Agent"
recipe "newrelic::java-agent", "Installs the New Relic Java agent."
recipe "newrelic::nodejs-agent", "Installs New Relic Node.js Agent"
recipe "newrelic::php-agent", "Installs the New Relic PHP agent."
recipe "newrelic::python-agent", "Installs the New Relic Python agent."
recipe "newrelic::ruby-agent", "Installs the New Relic Ruby agent."
recipe "newrelic::meetme-plugin-agent", "Installs the New Relic MeetMe plugin agent."
