# newrelic cookbook CHANGELOG

This file is used to list changes made in each version (>= 2.11.0) of the newrelic cookbook.

## v2.24.0

- support for PHP7
- parameterize dotnet agent config file
- properly follow through with hostname
- make documentation more consistent

## v2.23.3

- version incorrectly used and filename unused

## v2.23.2

- workaround inconsistencies in .zip file naming of New Relic download

## v2.23.1

- unzipping the agent with sudo broke when user didn't have sudo rights

## v2.23.0

- remove parsing of download page for Java-agent download
- include unzip-package for extracting newrelic.jar from zip
- addition of CentOS 7.2 platform integration tests

## v2.22.4

- minor syntax correction (server monitor)
- README.md fix(es)

## v2.22.3 (2016-08-23)

- get rid of confusing chefignore in cookbook repo, as it is actually only respected in the cookbook_path
- reimplementation of cookbook-path in Rakefile
- rework of version in metadata.rb

## v2.22.2 (2016-08-23)

- addition of quotes around cookbook name and cookbook category

## v2.22.1 (2016-08-23)

- workaround for [CHEF-3627](http://tickets.opscode.com/browse/CHEF-3627) in CI-setup
- adjustment to upload complete-matcher when uploading to the Chef Supermarket

## v2.22.0 (2016-08-23)

- CI-improvements
- fix for typo

## v2.21.0 (2016-08-03)

- remove friction and run tests via ChefDK

## v2.20.0 (2016-07-03)

- add usage of Java agent_action attribute
- ensure setting execute_php5enmod is meaningful
- DRY up Test Kitchen spec_helper
- bugfix: forward slashes must be escaped

## v2.19.0 (2016-04-01)

- MIA

## v2.18.0 (2016-01-22)

- MIA

## v2.17.0 (2015-11-18)

- MIA

## v2.16.0 (2015-09-17)

- Add verify_agent_config virtualenv support
- Refactoring: set agent_type and license as default in resources

## v2.15.1 (2015-09-17)

- Bugfix: Fedora is [not](https://github.com/chef/ohai/blob/master/lib/ohai/plugins/linux/platform.rb#L180) part of the RedHat platform_family

## v2.15.0 (2015-09-12)

- Make service action configurable; service_action will be restart by default as per New Relic docs
- Ability to add additional config

## v2.14.2 (2015-08-07)

- Trigger apt-get update run

## v2.14.1 (2015-07-27)

- Do not stop newrelic-daemon unnecessarily when using agent mode

## v2.14.0 (2015-07-23)

- Addition of matcher methods for resources
- Cleanup documentation on newrelic_deployment LWRP

## v2.13.0 (2015-06-19)

- Ability to configure the alert policy group when installing/removing server monitor

## v2.12.5 (2015-06-19)

- nodejs template update - make use of LWRP attributes
- Cleanup of unused attribute(s) in agent_java LWRP: owner > app_user and group > app_group

## v2.12.4 (2015-06-18)

- Bugfix: broken YML LWRP after 2.11.0

## v2.12.3 (2015-06-18)

- Bugfix: newrelic_lwrp_test::agent_java failed due to incorrect remote_file usage
- Bugfix: NodeJS cookbook default attribute to avoid capitalization issue with the New Relic agent
- Bugfix: Java agent provider was throwing a uninitialized constant Chef::Provider::File::SEPARATOR error due to a missing Ruby namespace resolution operator
- php -> python typo
- Take out unnecessary disabling of Metrics/AbcSize

## v2.12.2 (2015-06-01)

- Bugfix: illegal to set resource values during the provider execution

## v2.12.1 (2015-06-01)

- Bugfix: fixed detection of the java_agent execute_agent_action node attribute

## v2.12.0 (2015-05-23)

- Refactoring: convert other agents to lwrp
- Removal of non-ASCII characters in README.md
- Java agent upgrades: 'latest'
- support for labels in Java and Ruby agents

## v2.11.2 (2015-04-18)

- Bugfix: ssl attribute in server monitor, see issue #179
- General: 2.11.x cleanup

## v2.11.1 (2015-04-17)

- Bugfix: attribute that was previously potentially a TrueClass or FalseClass must be of type String, see issue #175

## v2.11.0 (2015-04-17)

- Refactoring: convert php agent and server monitor to lwrp
- Housekeeping: copyright
