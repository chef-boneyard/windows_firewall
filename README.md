windows_firewall Cookbook
====================
This cookbook configures windows firewall rules

Requirements
============

Platform
--------

* Windows Vista
* Windows 7
* Windows 8
* Windows Server 2008
* Windows Server 2008R2
* Windows Server 2012
* Windows Server 2012R2


Resources
-----------------

rule
==================

### Actions

:open - opens the specified port

# Attributes

firewall_rule attributes are as follows:

```
-name        - firewall rule name to create or delete.  You can use a name of 'all' in a delete to delete all rules that match other criteria
-description - firewall rule description
-localip    - can be 'any', a specific address, a subnet in CIDR or ip/mask notation, or a range separated by -
-localport  - can by 'any', an integer or one of {  rpc | rpc-epmap | iphttps | teredo | [ ,... ] } 
-remoteip   - can be 'any', a specific address, a subnet in CIDR or ip/mask notation, or a range separated by -
-remoteport - can by 'any', an integer or one of {  rpc | rpc-epmap | iphttps | teredo | [ ,... ] } 
-dir         - { in | out }
-protocol    - can by 'any', an integer, or one of { | icmpv4 | icmpv6 | icmpv4:type,code | icmpv6:type,code | tcp | udp } 
-fw_action   - { allow | block | bypass }
-profile     - { public | private | domain | any | [ ,... ] } ]
-program     - the path to the program
-service     - the short name of the service, or 'any'
-interface_type - { any | wireless | lan | ras } ]
```

### Examples

    windows_firewall_rule 'Apache' do
          port 8080
          protocol :TCP
          firewall_action :allow
    end

License & Authors

Author:: Matt Clifton (spartacus003@hotmail.com)
Copyright:: 2013-2015 Matt Clifton

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
