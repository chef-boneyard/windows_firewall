#
# Cookbook Name:: test
# Recipe:: default
# tests the firewall resource

# test localport as a comma sep list w/o spacing
windows_firewall_rule 'Apache' do
  local_port '8080,80'
  protocol 'TCP'
  firewall_action :allow
  program 'c:\program files\apache.exe'
  local_address '192.168.1.1'
end

# test localport as a comma sep list with spacing
windows_firewall_rule 'App1' do
  local_port '8080, 80'
  protocol 'TCP'
  firewall_action :allow
  program 'c:\program files\app2.exe'
  local_address '192.168.1.1'
end

# test local_port as an array
windows_firewall_rule 'App2' do
  local_port [8080, 80]
  protocol 'TCP'
  firewall_action :allow
  program 'c:\program files\app2.exe'
  local_address '192.168.1.1'
end

windows_firewall_rule 'Disable WinRM over HTTP' do
  local_port '5985'
  protocol 'TCP'
  firewall_action :block
  program 'c:\program files\test.exe'
  local_address '192.168.1.1'
end

windows_firewall_rule 'Enable SSH Access' do
  rule_name 'ssh'
  local_port '22'
  protocol 'TCP'
  firewall_action :allow
end

windows_firewall_rule 'Remove SSH Access' do
  rule_name 'ssh'
  action :delete
end
