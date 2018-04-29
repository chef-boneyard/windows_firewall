name             'windows_firewall'
maintainer       'Matt Clifton'
maintainer_email 'spartacus003@hotmail.com'
license          'Apache 2.0'
description      'Configures firewall rules on Windows'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/schubergphilis/windows_firewall'
issues_url       'https://github.com/schubergphilis/windows_firewall/issues'
supports         'windows'
version          '3.0.2'
chef_version '>= 12.7' if respond_to?(:chef_version)
