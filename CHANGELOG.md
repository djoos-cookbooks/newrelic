# newrelic cookbook CHANGELOG

This file is used to list changes made in each version (>= 2.11.0) of the newrelic cookbook.

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
