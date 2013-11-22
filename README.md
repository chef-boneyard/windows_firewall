windows_firewall Cookbook
====================
This cookbook configures windows firewall rules

Requirements
------------
None

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

### Examples

    windows_firewall_rule 'Apache' do
          port 8080
          protocol :TCP
          firewall_action :allow
    end