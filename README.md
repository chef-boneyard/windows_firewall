# windows_firewall Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/windows_firewall.svg)](https://supermarket.chef.io/cookbooks/windows_firewall) [![Build status](https://ci.appveyor.com/api/projects/status/39o3tnenw2njhw1b/branch/master?svg=true)](https://ci.appveyor.com/project/ChefWindowsCookbooks/windows-firewall/branch/master)

This cookbook configures Windows firewall rules.

``Note``: This resource is now built into chef-client 14.7+. If you are running Chef 14.7+ you no longer need to depend on this cookbook in your infrastructure of the windows_firewall_rule resource

## Requirements

### Platforms

- Windows 8, 8.1, 10
- Windows Server 2012 (R1, R2)
- Windows Server 2016

### Chef

- Chef 13+

## Resources

### windows_firewall_rule

#### Actions

- `:create` - creates a firewall rule
- `:delete` - deletes a firewall rule

#### properties

- `rule_name` The name of the firewall rule name to create. If not supplied the resource block name will be used.
- `description` The firewall rule description. Optional.
- `local_address` Can be 'any', a specific address, a subnet in CIDR or ip/mask notation, or a range separated by '-'
- `local_port` Can be 'any', an integer or one of { rpc | rpc-epmap | iphttps | teredo | [ ,... ] }
- `remote_address` Can be 'any', a specific address, a subnet in CIDR or ip/mask notation, or a range separated by '-''
- `remote_port` Can be 'any', an integer or one of { rpc | rpc-epmap | iphttps | teredo | [ ,... ] }
- `direction` Direction of the rule. Can be in or out. Default is in.
- `protocol` Can by 'any', an integer, or one of { | icmpv4 | icmpv6 | icmpv4:type,code | icmpv6:type,code | tcp | udp }
- `firewall_action` Can be allow, block, or bypass. Default is 'allow'
- `profile` Can be public, private, domain, or any
- `program` The path to the program.
- `service` The short name of the service, or 'any'
- `interface_type` Can be any, wireless, lan, or ras

#### Examples

```ruby
  windows_firewall_rule 'Apache' do
    local_port '8080'
    protocol 'TCP'
    firewall_action :allow
  end
```

```ruby
  windows_firewall_rule 'Enable SSH Access' do
    rule_name 'ssh'
    local_port '22'
    protocol 'TCP'
    firewall_action :allow
  end
```

```ruby
windows_firewall_rule 'Remove SSH Access' do
  rule_name 'ssh'
  action :delete
end
```

## License & Authors

- Author:: Matt Clifton (spartacus003@hotmail.com)
- Author:: Matt Stratton (matt.stratton@gmail.com)
- Author:: Tor Magnus Rakvåg (tor.magnus@outlook.com)
- Author:: Tim Smith (tsmith@chef.io)

```text
Copyright:: 2013-2015 Matt Clifton
Copyright:: 2018 Chef Software, Inc.
Copyright:: 2018, Intility AS


Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
