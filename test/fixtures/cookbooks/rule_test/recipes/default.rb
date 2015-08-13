#
# Cookbook Name:: rule_test
# Recipe:: default
# tests the firewall LWRP

windows_firewall_rule 'Apache' do
  localport '8080'
  protocol 'TCP'
  firewall_action :allow
  program 'c:\program files\test.exe'
  localip '192.168.1.1'
end

windows_firewall_rule 'Disable WinRM over HTTP' do
  localport '5985'
  protocol 'TCP'
  firewall_action :block
  program 'c:\program files\test.exe'
  localip '192.168.1.1'
end
