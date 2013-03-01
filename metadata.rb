maintainer       "Escape Studios"
maintainer_email "dev@escapestudios.com"
license          "MIT"
description      "Installs/Configures New Relic"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.4.2"

%w{ debian ubuntu redhat centos fedora scientific amazon }.each do |os|
supports os
end

recommends "php"
recommends "python"