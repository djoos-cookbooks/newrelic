# NewRelic helpers
module NewRelic
  # helpers module
  module Helpers
    def newrelic_repository
      install_newrelic_repo
    end

    def newrelic_repository_infrastructure
      install_newrelic_repo_infrastructure
    end

    def check_license
      # check license key provided
      raise 'The NewRelic key is required.' if new_resource.license.nil?
    end

    def install_newrelic_repo
      case node['platform_family']
      when 'debian'
        install_newrelic_repo_debian
      when 'rhel', 'fedora', 'amazon'
        install_newrelic_repo_rhel
      end
    end

    def install_newrelic_repo_debian
      apt_repository 'newrelic' do
        uri node['newrelic']['repository']['uri']
        distribution node['newrelic']['repository']['distribution']
        components node['newrelic']['repository']['components']
        key node['newrelic']['repository']['key']
      end
    end

    def install_newrelic_repo_rhel
      yum_repository 'newrelic' do
        description 'New Relic packages for Enterprise Linux 5 - $basearch'
        baseurl node['newrelic']['repository']['uri']
        gpgkey node['newrelic']['repository']['key']
        sslverify node['newrelic']['repository']['ssl_verify']
        proxy node['newrelic']['repository']['proxy'] unless node['newrelic']['repository']['proxy'].nil?
        proxy_username node['newrelic']['repository']['proxy_username'] unless node['newrelic']['repository']['proxy_username'].nil?
        proxy_password node['newrelic']['repository']['proxy_password'] unless node['newrelic']['repository']['proxy_password'].nil?
      end
    end

    def install_newrelic_repo_infrastructure
      case node['platform_family']
      when 'debian'
        install_newrelic_repo_infrastructure_debian
      when 'rhel', 'fedora', 'amazon'
        install_newrelic_repo_infrastructure_rhel
      end
    end

    def install_newrelic_repo_infrastructure_debian
      apt_repository 'newrelic-infra' do
        uri node['newrelic']['repository']['infrastructure']['uri']
        distribution deb_version_to_codename(node['platform_version'].to_i)
        components node['newrelic']['repository']['infrastructure']['components']
        key node['newrelic']['repository']['infrastructure']['key']
        arch 'amd64'
      end
    end

    def install_newrelic_repo_infrastructure_rhel
      yum_repository 'newrelic-infra' do
        description 'New Relic Infrastructure'
        baseurl node['newrelic']['repository']['infrastructure']['uri']
        gpgkey node['newrelic']['repository']['infrastructure']['key']
        sslverify node['newrelic']['repository']['infrastructure']['ssl_verify']
        gpgcheck true
        repo_gpgcheck true
      end
    end

    def deb_version_to_codename(version)
      deb_version_to_codename = {
        7 => 'wheezy',
        8 => 'jessie',
        9 => 'stretch',
        10 => 'buster',
        12 => 'precise',
        14 => 'trusty',
        16 => 'xenial'
      }

      deb_version_to_codename[version]
    end

    def directory_exists?(dir)
      return false unless ::File.exist?(dir)
      true
    end
  end
end
