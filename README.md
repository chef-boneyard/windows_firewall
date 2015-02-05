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

-attribute :name, :kind_of => String, :name_attribute => true
-attribute :direction, :kind_of => Symbol, :default => :in, :equal_to => [:in, :out]
-attribute :protocol, :kind_of => Symbol, :default => :TCP, :equal_to => [:TCP]
-attribute :firewall_action, :kind_of => Symbol, :default => :allow, :equal_to => [:allow, :deny]
-attribute :localport, :kind_of => String, :default => :Any
-attribute :remoteport, :kind_of => String, :default => :Any
-attribute :program, :kind_of => String, :default => :Any
-attribute :remoteaddress, :kind_of => String, :default => :Any


### Examples

    windows_firewall_rule 'Apache' do
        localport "8080"
        protocol :TCP
        firewall_action :allow
		direction :in
    end