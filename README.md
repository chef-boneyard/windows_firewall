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

#### localip

localip is compared to the Destination IP address field of an inbound network packet. It is compared to the Source IP address field of an outbound network packet. 
localip can be any of the following values:
any. Matches any IP address.

IPAddress. Matches only the exact IPv4 or IPv6 address.

IPSubnet. Matches any IPv4 or IPv6 address that is part of the specified subnet. The format is the subnet address, followed by '/' and then either the number of bits in the subnet mask or the subnet mask itself.

IPRange. Matches any IPv4 or IPv6 addresses that fall within the specified range. The format is the starting and ending IP addresses of the range separated by a '-'.

Multiple entries can be specified for localip by separating them with a comma. Do not include any spaces.

#### remoteip

remoteip is compared to the Destination IP address field of an outbound network packet. It is compared to the Source IP address field of an inbound network packet.
remoteip can be any of the following values:
any. Matches any IP address.

localsubnet. Matches any IP address that is on the same IP subnet as the local computer.

dns|dhcp|wins|defaultgateway. Matches the IP address of any computer that is configured as the identified server type on the local computer.

IPAddress. Matches only the exact IPv4 or IPv6 address specified.

IPSubnet. Matches any an IPv4 or IPv6 subnet that is part of the specified subnet. The format is the subnet address, followed by '/' and then either the number of bits in the subnet mask or the subnet mask itself.

IPRange. Matches any IPv4 or IPv6 addresses that fall within the specified range. The format is the starting and ending IP addresses of the range separated by a '-'.

Multiple entries can be specified for remoteip by separating them with a comma.

