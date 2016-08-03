require 'rspec/core/rake_task'

namespace :style do
  require 'rubocop/rake_task'
  require 'foodcritic'

  desc 'Run Ruby style checks (RuboCop)'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks (FoodCritic)'
  FoodCritic::Rake::LintTask.new(:chef) do |task|
    task.options = {
      :tags => ['~FC037'],
      :fail_tags => ['any']
    }
  end
end

desc 'Run all syntax/lint checks'
task :style => ['style:ruby', 'style:chef']

desc 'Run ChefSpec tests'
RSpec::Core::RakeTask.new(:spec)

# integration testing: Test Kitchen
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

desc 'Run lint checks'
task :lint => ['style']

desc 'Run unit tests'
task :unit => ['spec']

desc 'Run all integration tests'
task :integration => ['integration:vagrant']

desc 'Run tests on Travis CI'
task :travis => [:lint, :unit]

task :default => [:lint, :unit, :integration]
