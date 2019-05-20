# HireIQ Changes

Quick summary of changes made by HireIQ post-fork:

- Allow attribute overrides in the style of the old Chef 11 OpsWorks recipes.
- Unpin version of 'ark' as it would conflict with HireIQ's pin
- Add trusted=true to apt_repository to stop Chef crash on Ubuntu 18.04, repository not signed.
- Let python_agent recipe get a "python" attribute to set the runtime explicitly
