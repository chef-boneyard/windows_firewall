# CHANGELOG for windows_firewall

This file is used to list changes made in each version of windows_firewall.

## 5.0.1 (2018-11-08)

- Remove 2008r2/8 support from the readme since we don't actually support them
- Allow local_port and remote_port to take a comma separated list or ports, integers, or arrays of string/integers.
- Avoid deprecation warnings on Chef 14.7+

## 5.0.0 (2018-10-31)

- The windows_firewall_entry resource has been mostly rewritten to use PowerShell and provide full idempotency. This resolves a large number of outstainding issues with the resource and gets it ready for inclusion in the chef-client itself
- This cookbook now requires Chef 13.0 or later
- AppVeyor testing of all PRs has been enabled
- Multiple property names have been changed in this new version. The existing names will continue to work, but in chef-client 14.7 they will begin to throw deprecation warnings
  - localip -> local_address
  - remoteip -> remote_address
  - localport -> local_port
  - remoteport -> remote_port
  - interfacetype -> interface_type

## 4.1.0 (2018-09-29)

- Avoid extra spaces in the create shellout
- Add a helper to double quote values for the command line
- Make it more obvious how we're checking for empty values
- Add support for running on localized versions of Windows

## 4.0.2 (2018-05-09)

- Updated the readme to match resource actions / properties
- Skipped building out the command line options unless we actually need to run a command in order to speed up no-op runs

## 4.0.1 (2018-05-04)

- Fix failures loading current state

## 4.0.0 (05-03-2018)

### Breaking Changes

- The empty default recipe has been removed
- The existing LWRP has been converted to a custom resource requiring Chef 12.7 or later

### Other Changes

- The resource now includes a :delete action for removing rules by name
- The resource now loads the current rule state and converges if the rule is missing. This will show up properly in reporting and no longer requires and batch resource to converge
- A name_property of rule_name has been added to the resource allowing you to use a friendly name for the resource name while still specifying the actual firewall rule name
- chef_version, issue_url and source_url metadata added
- All foodcritic warnings resolved
- All cookstyle warnings resolved
- Added delivery local mode for linting/unit testing -

## 3.0.1

- Fix issue with incorrect use of "deny" as a firewall action. Resource now validates for "allow", "block", or "bypass"

## 3.0.0

BREAKING CHANGES The protocol attribute was changed from a symbol to a string. If you were explicitly referencing this attribute in your recipes, you will need to update all usages to a string, or remove each usage to rely on the default value ('TCP'):

```
    windows_firewall_rule 'Apache' do
          protocol 'TCP' # was protocol :TCP
          ...
    end
```

## 2.0.0

BREAKING CHANGES

- Change default action :open to :create

MAJOR CHANGE

- Test-kitchen support (only for Windows 2012R2 currently, but tests version 11 and 12 of chef-client)
- Update metadata with proper attribution as well as Apache license
- Add more attributes (including remoteip, program, service, etc)
- Most attributes are set to nil by default and only added to the command if present
- Style cleanup from rubocop and foodcritic
- Use batchresource instead of windows_batch
- Bumps cookbook version to 2.0

## 0.2.0

Added remoteip and localip attributes. Added Berksfile and preliminary test-kitchen harness. Several bits of cleanup that should not introduce any breaking changes, but a version bump seemed prudent.

## 0.1.0:

- Initial release of windows_firewall

--------------------------------------------------------------------------------

Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
