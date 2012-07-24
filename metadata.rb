maintainer       "Escape Studios"
maintainer_email "dev@escapestudios.com"
license          "MIT"
description      "Installs/Configures New Relic"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.5"

supports "ubuntu"
supports "debian"
supports "centos"
supports "redhat"
supports "fedora"

depends "apache2"
depends "php"
depends "python"