# newrelic cookbook CHANGELOG

This file is used to list changes made in each version (>= 2.11.0) of the newrelic cookbook.

## v2.39.0
- add distributed_tracing attribute for Java and Ruby APM

## v2.38.2
- Fix linux service provider for Amazon Linux 2 support

## v2.38.1
- Fix .NET agent configuration when a proxy is specified

## v2.38.0
- update file permission for infra agent YML config file

## v2.37.0
- lazy evaluation of license attribute(s)

## v2.36.1
- download path to DotNet agent has changed, again...

## v2.36.0
- support for amazon linux 2018
- allow installing on-host integrations package
- repository attribute for java agent download
- multiple application names for Windows

## v2.35.1
- fix Travis CI build

## v2.35.0
- add error_collector_ignore_classes attribute for java_agent

## v2.34.0
- allow custom attributes for infrastructure agent

## v2.33.0
- bring dotnet agent's README, attribute and recipe in sync
- fix dotnet MSI download url, given New Relic changed it all of a sudden...

## v2.32.0
- add error_collector_ignore_errors attribute for php_agent
- fixed location of closing tag for service element

## v2.31.2
- added upstart support for Amazon Linux (infrastructure agent)

## v2.31.1
- download server monitor msi over https
- ChefSpec update(s) - version bumps

## v2.31.0
- write infrastructure license before package
- set service provisioner to Upstart for ubuntu < 16.04
- bump Chef version in README (caused by poise-python dependency)
- ChefSpec fix(es) - String (or Array) key on apt_repository is treated as Array upon inspection
- FoodCritic fix(es) - FC028: Incorrect #platform? usage

## v2.30.0
- logic for repository proxy for RHEL
- support for Amazon Linux in Chef 13

## v2.29.0
- implementation of the New Relic Infrastructure Agent

## v2.28.1
- addition of CHANGELOG entry for version 2.28.0

## v2.28.0
- addition of ssl verify on yum_repository for those that have a mirror yum repo with a self-signed certificate

## v2.27.1

- integration test fix(es)

## v2.27.0

- swapping out python for poise-python as its deprecated
- additional (integration) test suite: python-agent
- added the ability to specify New Relic NodeJS agent version
- rename test fixture cookbook: newrelic_poc > newrelic_lwrp_test
- adding other_options to server_monitor

## v2.26.0

- (feature) class transformer configuration support for Java agent
- (bugfix) default agent_actions converted to strings
- (bugfix) for missing erb tag for feature_flag variable (#289)

## v2.25.0

- don't verify the Python agent configuration on every Chef run
- Rubocop fix(es) for cops in latest Chef DK version

## v2.24.2

- updated version constraint for apt cookbook

## v2.24.1

- fix for enable_custom_tracing when using newrelic_yml-LWRP directly

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
