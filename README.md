# windows_firewall Cookbook

This cookbook configures Windows firewall rules.

# **3.0 Breaking Changes**

The protocol attribute was changed from a symbol to a string. If you were explicitly referencing this attribute
in your recipes, you will need to update all usages to a string, or remove each usage to rely on the default value ('TCP'):

```
    windows_firewall_rule 'Apache' do
          protocol 'TCP' # was protocol :TCP
          ...
    end
```

# Requirements
Version 2.0.0+ of this cookbook requires Chef 11+

## Platforms

* Windows Vista
* Windows 7
* Windows 8
* Windows Server 2008
* Windows Server 2008R2
* Windows Server 2012
* Windows Server 2012R2

## Usage
In your recipe, you can use the `windows_firewall_rule` resource.  Currently, the only supported action is `:create`. Attribute defaults match the netsh advfirewall defaults if they are required by netsh advfirewall, otherwise they are set to 'nil'.

This is a resource-only cookbook, and adding the default recipe to a node's runlist will have no effect.

## Resources

### windows_firewall_rule

#### Actions

:create - creates a firewall rule with the parameters supplied

#### Attribute Parameters

- `name` Name attribute. The name of the firewall rule name to create.
- `description` The firewall rule description. Optional.
- `localip` Can be 'any', a specific address, a subnet in CIDR or ip/mask notation, or a range separated by '-'
- `localport` Can be 'any', an integer or one of {  rpc | rpc-epmap | iphttps | teredo | [ ,... ] }
- `remoteip` Can be 'any', a specific address, a subnet in CIDR or ip/mask notation, or a range separated by '-''
- `remoteport` Can be 'any', an integer or one of {  rpc | rpc-epmap | iphttps | teredo | [ ,... ] }
- `dir` Direction of the rule. Can be in or out. Default is in.
- `protocol` Can by 'any', an integer, or one of { | icmpv4 | icmpv6 | icmpv4:type,code | icmpv6:type,code | tcp | udp }
- `firewall_action` Can be allow, block, or bypass. Default is 'allow'
- `profile` Can be public, private, domain, or any
- `program` The path to the program.
- `service` The short name of the service, or 'any'
- `interface_type` Can be any, wireless, lan, or ras


#### Examples

```
    windows_firewall_rule 'Apache' do
          localport '8080'
          protocol 'TCP'
          firewall_action :allow
    end
```

## License & Authors

* Author:: Matt Clifton (spartacus003@hotmail.com)
* Author:: Matt Stratton (matt.stratton@gmail.com)

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
