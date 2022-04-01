name 'newrelic'
maintainer 'David Joos'
maintainer_email 'development@davidjoos.com'
license 'MIT'
description 'Installs/Configures New Relic'
version '2.44.0'
chef_version '>= 0.10.0'

%w(debian ubuntu redhat centos fedora scientific amazon windows smartos oracle).each do |os|
  supports os
end

source_url 'https://github.com/djoos-cookbooks/newrelic'
issues_url 'https://github.com/djoos-cookbooks/newrelic/issues'

depends 'curl'
depends 'apt'
depends 'yum'
