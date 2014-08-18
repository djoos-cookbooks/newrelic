source 'https://rubygems.org'

gem 'rake'

group :lint do
  gem 'rubocop', '~> 0.18'
  gem 'foodcritic', '~> 3.0'
end

group :unit, :integration do
  gem 'berkshelf',  '~> 3.0'
end

group :unit do
  gem 'chefspec', '~> 3.1'
  gem 'rspec-expectations', '~> 2.14.0'
end

group :integration do
  gem 'test-kitchen', '~> 1.2'
  gem 'kitchen-vagrant', '~> 0.11'
  gem 'serverspec', '~> 1.0'
end
