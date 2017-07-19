require 'rspec/core/rake_task'
require 'chef/cookbook/metadata'
require 'yaml'

environment = ENV['ENVIRONMENT'] || ''

# this module groups useful general commands together
module GeneralCommands
  @logging = ENV['LOGGING'] || true

  def self.run(cmd, *expected_exitstatuses)
    puts "+ #{cmd}" if @logging
    output = `#{cmd} 2>&1`
    puts output.gsub(/^/, '- ') if @logging
    expected_exitstatuses << 0 if expected_exitstatuses.empty?
    error_message = "ERROR: '#{cmd}' failed with exit status #{$CHILD_STATUS.exitstatus}"
    raise StandardError, error_message unless [expected_exitstatuses].flatten.include?($CHILD_STATUS.exitstatus)
    output
  end

  def self.parse_metadata(metadata_file = 'metadata.rb')
    metadata = Chef::Cookbook::Metadata.new
    metadata.from_file(metadata_file)

    metadata
  end
end

# this module groups useful release commands together
module ReleaseCommands
  def self.ensure_working_directory_state(allowed_modified_files = [])
    modified_files = GeneralCommands.run('git diff --name-only', 0, 1)
    modified_files = modified_files.split(/\n+/)

    return if allowed_modified_files.uniq.sort == modified_files.uniq.sort
    raise '[RELEASE] Working directory is in an unexpected state'
  end

  def self.verify_tag(should_exist = false)
    return if GeneralCommands.run("git rev-parse -q --verify \"refs/tags/#{version}\"", 0, 1).empty? != should_exist

    suffix = if should_exist == true
               'does not exist'
             else
               'already exists'
             end

    raise "[RELEASE] Tag (#{version}) #{suffix}"
  end

  def self.version
    GeneralCommands.parse_metadata.version
  end

  def self.name
    GeneralCommands.parse_metadata.name
  end

  def self.category
    file_name = '.category'

    if File.exist?(file_name)
      File.read(file_name).strip
    else
      ''
    end
  end

  def self.pre_publish
    GitCommands.ensure_branch('master')

    ReleaseCommands.ensure_working_directory_state
  end

  def self.publish_to_scm
    ReleaseCommands.pre_publish

    ReleaseCommands.verify_tag(false)

    puts 'Creating an annotated tag...'
    GitCommands.tag(ReleaseCommands.version)

    puts 'Push tag to remote repository...'
    GitCommands.push_tags('origin', 'master', ReleaseCommands.version)
  end

  def self.publish_to_chef_server
    ReleaseCommands.pre_publish

    ReleaseCommands.verify_tag(true)

    puts 'Updating Berkshelf...'
    BerkshelfCommands.update

    puts 'Packaging cookbooks (creating a single archive containing all of your required cookbooks)'
    BerkshelfCommands.package('cookbooks.tar.gz')

    puts 'Installing packaged cookbooks into Chef Server'
    BerkflowCommands.install('cookbooks.tar.gz')
  end

  def self.publish_to_chef_supermarket
    ReleaseCommands.pre_publish

    ReleaseCommands.verify_tag(true)

    cookbook_name = ReleaseCommands.name
    cookbook_category = ReleaseCommands.category

    if cookbook_name.blank? || cookbook_category.blank?
      puts 'Skipped sharing to the Chef Supermarket - cookbook name and/or category not set. Set it and run \'publish:chef:supermarket\' separately if needed.'
    else
      puts 'Sharing to the Chef Supermarket...'

      KnifeCommands.share(cookbook_name, cookbook_category)
    end
  end

  def self.release(environment = '')
    raise 'You must specify an environment name.' if environment.blank?

    ReleaseCommands.ensure_working_directory_state
    ReleaseCommands.verify_tag(true)

    puts "Applying the cookbook version locks to the '#{environment}'-Chef environment"
    BerkshelfCommands.apply(environment)
  end
end

# this module groups useful berkshelf commands together
module BerkshelfCommands
  def self.update
    return if GeneralCommands.run('chef exec berks update', 0, 1)
    raise '[BERKSHELF] Failed to update'
  end

  def self.package(archive_filename = 'cookbooks.tar.gz')
    raise '[BERKSHELF] You must specify an archive filename.' if archive_filename.blank?

    return if GeneralCommands.run("chef exec berks package #{archive_filename}", 0, 1)
    raise "[BERKSHELF] Failed to create #{archive_filename}-archive"
  end

  def self.apply(environment = '')
    raise '[BERKSHELF] You must specify an environment.' if environment.blank?

    return unless GeneralCommands.run("chef exec berks apply #{environment}", 0, 1).empty?
    raise "[BERKSHELF] Failed to apply the cookbook version locks to the '#{environment}'-Chef environment"
  end
end

# this module groups useful berkflow commands together
module BerkflowCommands
  def self.install(archive_filename = 'cookbooks.tar.gz')
    raise '[BERKFLOW] You must specify an archive filename.' if archive_filename.blank?

    return if /Done./ =~ GeneralCommands.run("chef exec blo in #{archive_filename}", 0, 1)
    raise "[BERKFLOW] Failed to install packaged cookbooks #{archive_filename} into Chef Server"
  end
end

# this module groups useful git commands together
module GitCommands
  def self.ensure_branch(branch = 'master')
    raise '[GIT] You must specify a branch.' if branch.blank?

    return if /#{branch}/ =~ GeneralCommands.run('git rev-parse --abbrev-ref HEAD', 0, 1)
    raise '[GIT] Currently working on unexpected branch'
  end

  def self.tag(tag = '')
    raise '[GIT] You must specify a tag.' if tag.blank?

    return if GeneralCommands.run("git tag -a #{tag} -m '#{tag}'", 0, 1)
    raise '[GIT] Failed to tag'
  end

  def self.push_tags(remote = 'origin', branch = 'master', tag = '')
    raise '[GIT] You must specify a remote.' if remote.blank?
    raise '[GIT] You must specify a branch.' if branch.blank?
    raise '[GIT] You must specify a tag.' if tag.blank?

    return if GeneralCommands.run("git push #{remote} #{branch} --tags", 0, 1)
    raise '[GIT] Failed to push to remote'
  end
end

# this module groups useful knife commands together
module KnifeCommands
  def self.share(cookbook_name = '', cookbook_category = '')
    raise '[KNIFE] Missing cookbook name.' if cookbook_name.blank?
    raise '[KNIFE] Missing cookbook category.' if cookbook_category.blank?

    return if /Upload complete/ =~ GeneralCommands.run("chef exec knife supermarket share '#{cookbook_name}' '#{cookbook_category}' --cookbook-path ../", 0, 1)
    raise "[KNIFE] Failed to publish the #{cookbook_name}-cookbook on the Chef Supermarket"
  end
end

namespace :style do
  require 'rubocop/rake_task'
  require 'foodcritic'

  desc 'Run Ruby style checks (RuboCop)'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks (FoodCritic)'
  FoodCritic::Rake::LintTask.new(:chef)
end

desc 'Run all syntax/lint checks'
task :style => ['style:ruby', 'style:chef']

desc 'Run ChefSpec tests'
RSpec::Core::RakeTask.new(:spec)

namespace :integration do
  require 'kitchen'

  desc 'Run integration tests (Test Kitchen & Vagrant)'
  task :vagrant do
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end
end

namespace :publish do
  desc 'Publish to SCM'
  task :scm do
    ReleaseCommands.publish_to_scm
  end

  namespace :chef do
    desc 'Publish to Chef Server'
    task :server do
      ReleaseCommands.publish_to_chef_server
    end

    desc 'Publish to Chef Supermarket'
    task :supermarket do
      ReleaseCommands.publish_to_chef_supermarket
    end
  end

  task :all => ['scm', 'chef:supermarket', 'chef:server']
end

desc 'Run lint checks'
task :lint => %w[style]

desc 'Run unit tests'
task :unit => %w[spec]

desc 'Run Travis CI tests'
task :travis => %w[lint unit]

desc 'Run all integration tests'
task :integration => %w[integration:vagrant]

desc 'Publish'
task :publish => %w[publish:scm publish:chef:supermarket publish:chef:server]

desc 'Release'
task :release do
  ReleaseCommands.release(environment)
end

task :default => %w[lint unit integration]
