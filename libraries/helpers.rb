# Newrelic helpers
module Newrelic
  # helpers module
  module Helpers
    def newrelic_repository
      install_wget node
      install_newrelic_repo
    end

    def check_license
      # Check license key provided
      fail 'The Newrelic key is required to notify New Relic of a deployment.' if new_resource.license.nil?
    end

    def install_wget(node)
      case node['platform_family']
      when 'debian', 'rhel', 'fedora'
        package 'wget'
      end
    end

    def install_newrelic_repo
      debian_newrelic_repo if node['platform_family'] == 'debian'
      rhel_newrelic_repo if node['platform_family'] == ('rhel' || 'fedora')
    end

    def debian_newrelic_repo
      apt_repository 'newrelic' do
        uri 'http://apt.newrelic.com/debian/'
        distribution 'newrelic'
        components ['non-free']
        key 'https://download.newrelic.com/548C16BF.gpg'
      end
    end

    def rhel_newrelic_repo
      yum_repository 'newrelic' do
        description 'New Relic packages for Enterprise Linux 5 - $basearch'
        baseurl 'https://yum.newrelic.com/pub/newrelic/el5/$basearch'
        gpgcheck false
        action :create
      end
    end
  end
end
