newrelic cookbook CHANGELOG
===========================
This file is used to list changes made in each version (> 2.0.0) of the newrelic cookbook.

v2.0.0 (2014-07-02)
-------------------
- Refactoring: separation of New Relic MeetMe plugin logic into separate cookbook: https://github.com/escapestudios-cookbooks/newrelic_meetme_plugin
- Refactoring: "use snake_case for source file names" + RuboCop FileName-check
- Don't rely on this cookbook to get the specific agent's application set up; state that particular logic in a run list instead
- Addition of CHANGELOG.md