# CHANGELOG for windows_firewall

This file is used to list changes made in each version of windows_firewall.

## 3.0.1

* Fix issue with incorrect use of "deny" as a firewall action. Resource now validates for "allow", "block", or "bypass"

## 3.0.0

BREAKING CHANGES
The protocol attribute was changed from a symbol to a string. If you were explicitly referencing this attribute in your recipes, you will need to update all usages to a string, or remove each usage to rely on the default value ('TCP'):
```
    windows_firewall_rule 'Apache' do
          protocol 'TCP' # was protocol :TCP
          ...
    end
```

## 2.0.0

BREAKING CHANGES
* Change default action :open to :create

MAJOR CHANGE
* Test-kitchen support (only for Windows 2012R2 currently, but tests version 11 and 12 of chef-client)
* Update metadata with proper attribution as well as Apache license
* Add more attributes (including remoteip, program, service, etc)
* Most attributes are set to nil by default and only added to the command if present
* Style cleanup from rubocop and foodcritic
* Use batchresource instead of windows_batch
* Bumps cookbook version to 2.0

## 0.2.0

Added remoteip and localip attributes. Added Berksfile and preliminary test-kitchen harness. Several bits of cleanup that should not introduce any breaking changes, but a version bump seemed prudent.

## 0.1.0:

* Initial release of windows_firewall

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
