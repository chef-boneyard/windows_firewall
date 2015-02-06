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

### Attribute Parameters

- attribute :port, :kind_of => Integer
- attribute :name, :kind_of => String, :name_attribute => true
- attribute :direction, :kind_of => Symbol, :default => :in, :equal_to => [:in, :out]
- attribute :protocol, :kind_of => Symbol, :default => :TCP, :equal_to => [:TCP]
- attribute :firewall_action, :kind_of => Symbol, :default => :allow, :equal_to => [:allow, :deny]
- attribute :localip, :kind_of => String
- attribute :remoteip, :kind_of => String

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
