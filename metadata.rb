name             "newrelic"
maintainer       "Escape Studios"
maintainer_email "dev@escapestudios.com"
license          "MIT"
description      "Installs/Configures New Relic"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.4.7"

%w{ debian ubuntu redhat centos fedora scientific amazon }.each do |os|
supports os
end

recommends "php"
recommends "python"

recipe "newrelic", "Adds the New Relic repository, installs & configures the New Relic server monitor package."
recipe "newrelic::install", "Adds the New Relic repository."
recipe "newrelic::server-monitor", "Installs & configures the New Relic server monitor package."
recipe "newrelic::php-agent", "Installs the New Relic PHP agent."
recipe "newrelic::python-agent", "Installs the New Relic Python agent."