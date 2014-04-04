require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'
require 'kitchen'

#syntax/lint checks
namespace :lint do
    desc 'Run Ruby syntax/lint checks'
    Rubocop::RakeTask.new(:ruby)

    desc 'Run Chef syntax/lint checks'
    FoodCritic::Rake::LintTask.new(:chef) { |task| 
        task.options = { fail_tags: ['any'] }
    }
end

desc 'Run all syntax/lint checks'
task lint: ['lint:ruby', 'lint:chef']

#unit testing: ChefSpec
desc 'Run RSpec and ChefSpec unit tests'
RSpec::Core::RakeTask.new(:unit)

#integration testing: Test Kitchen
namespace :integration do
    desc 'Run Test Kitchen integration tests with Vagrant'
    task :vagrant do
        Kitchen.logger = Kitchen.default_file_logger
        Kitchen::Config.new.instances.each do |instance|
            instance.test(:always)
        end
    end
  
#    desc 'Run Test Kitchen integration tests with cloud plugins'
#    task :cloud do
#        run_kitchen = true
#        if ENV['TRAVIS'] == 'true' && ENV['TRAVIS_PULL_REQUEST'] != 'false'
#            run_kitchen = false
#        end
#    
#        if run_kitchen
#            Kitchen.logger = Kitchen.default_file_logger
#            @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.cloud.yml')
#            config = Kitchen::Config.new( loader: @loader)
#            config.instances.each do |instance|
#                instance.test(:always)
#            end
#        end
#    end
end

desc 'Run all integration tests'
#task integration: ['integration:vagrant', 'integration:cloud']
task integration: ['integration:vagrant']

#Travic CI
desc 'Run tests on Travis CI'
task travis: ['lint', 'unit']

#the default rake task should just run it all
task default: ['lint', 'unit', 'integration']