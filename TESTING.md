# Testing the cookbook

Contributions to this cookbook will only be accepted if all tests pass successfully.

## Setting up the test environment

Install the latest stable version of [ChefDK](https://downloads.chef.io/chef-dk/). You'll need [Vagrant](http://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads) for running integration tests.

## Running tests

### Style checks

`chef exec rake style`

### Unit tests

`chef exec rake unit`

## Integration tests

`chef exec rake integration`

## All checks/tests

`chef exec rake`
