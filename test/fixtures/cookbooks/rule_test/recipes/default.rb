#
# Cookbook Name:: rule_test
# Recipe:: default
# tests the firewall LWRP


windows_firewall_rule 'Apache' do
      port 8080
      protocol :TCP
      firewall_action :allow
      localip '192.168.1.1'
end