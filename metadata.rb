name             'windows_firewall'
maintainer       'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license          'Apache-2.0'
description      'Configures firewall rules on Windows'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/chef-cookbooks/windows_firewall'
issues_url       'https://github.com/chef-cookbooks/windows_firewall/issues'
supports         'windows'
version          '4.1.0'
chef_version     '>= 12.7' if respond_to?(:chef_version)
