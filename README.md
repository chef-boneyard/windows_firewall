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

