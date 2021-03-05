#
# Cookbook Name:: newrelic
# Recipe:: agent_dotnetcore
#
#

# include helper methods
include NewRelic::Helpers

use_inline_resources if defined?(use_inline_resources)

action :install do
  check_license
  newrelic_repository
  newrelic_install
end

action :remove do
  remove_newrelic
end

def newrelic_install
  # run newrelic-install dependent on execution platform_family
  case node['platform_family']
  when 'debian', 'rhel', 'amazon'
    install_newrelic_dotnetcore_linux
  when 'windows'
    install_newrelic_dotnetcore_windows
  end
end

def install_newrelic_dotnetcore_linux
  case node['platform_family']
  when 'debian'
    install_newrelic_apt
  when 'rhel', 'amazon'
    install_newrelic_yum
  end

  magic_shell_environment 'CORECLR_NEWRELIC_HOME' do
    action :add
    value new_resource.CoreCLR_NewRelic_home
  end

  template "#{new_resource.CoreCLR_NewRelic_home}/newrelic.config" do
    cookbook new_resource.cookbook
    source new_resource.source
    variables(
      :resource => new_resource
    )
    sensitive true
  end
end

def install_newrelic_apt
  apt_update 'update' do
    action :update
  end
  apt_package 'Install New Relic .Net Core Agent using apt' do
    package_name 'newrelic-netcore20-agent'
    action :upgrade
  end
end

def install_newrelic_yum
  yum_package 'newrelic-netcore20-agent' do
    flush_cache [:before]
    allow_downgrade true
    package_name 'newrelic-netcore20-agent'
    action :install
  end
end

def install_newrelic_dotnetcore_windows
  zipfile 'unzip source to NewRelic directory' do
    from new_resource.https_download
    into new_resource.config_dir
    not_if { ::File.exist?('#{new_resource.config_dir}\NewRelic.Profiler.dll') }
  end

  env 'CORECLR_NEWRELIC_HOME' do
    action :create
    value new_resource.config_dir
  end

  env 'CORECLR_PROFILER' do
    action :create
    value '{36032161-FFC0-4B61-B559-F6C5D41BAE5A}'
  end

  env 'CORECLR_PROFILER_PATH' do
    action :create
    value '%CORECLR_NEWRELIC_HOME%\NewRelic.Profiler.dll'
  end

  template "#{new_resource.config_dir}\\newrelic.config" do
    cookbook new_resource.cookbook
    source new_resource.source
    variables(
      :resource => new_resource
    )
    sensitive true
  end
end
