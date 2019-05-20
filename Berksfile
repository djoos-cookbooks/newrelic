source 'https://supermarket.chef.io'

# uninitialized constant Win32 caused by ark-cookbook change in v1.2.0
# (https://github.com/chef-cookbooks/ark/commit/0012c57188ff6e7df2ac69883c029bb88ce001e2)
cookbook 'ark', '= 1.1.0'

group :integration do
  cookbook 'newrelic_lwrp_test', :path => 'test/fixtures/cookbooks/newrelic_lwrp_test'
end

metadata
