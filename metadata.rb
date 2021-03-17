name 'newrelic'
maintainer 'David Joos'
maintainer_email 'development@davidjoos.com'
license 'MIT'
description 'Installs/Configures New Relic'
version '2.43.1'
chef_version '>= 0.10.0'

%w(debian ubuntu redhat centos fedora scientific amazon windows smartos oracle).each do |os|
  supports os
end

source_url 'https://github.com/djoos-cookbooks/newrelic'
issues_url 'https://github.com/djoos-cookbooks/newrelic/issues'

depends 'poise-python'
depends 'curl'
depends 'apt'
depends 'yum'
