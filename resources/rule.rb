#
# Cookbook Name:: windows_firewall
# Resource:: rule
#
# Author:: Matt Clifton (spartacus003@hotmail.com)
# Author:: Matt Stratton (matt.stratton@gmail.com)
# Author:: Tor Magnus Rakvåg (tor.magnus@outlook.com)
# Author:: Tim Smith (tsmith@chef.io)
# Copyright:: 2013-2015 Matt Clifton
# Copyright:: 2018, Chef Software, Inc.
# Copyright:: 2018, Intility AS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

chef_version_for_provides '< 14.7' if respond_to?(:chef_version_for_provides)
resource_name :windows_firewall_rule

require 'chef/json_compat'

property :rule_name, String, name_property: true
property :description, String, default: 'Firewall rule'
property :local_address, String
property :local_port, [String, Integer, Array],
         coerce: proc { |d| d.is_a?(String) ? d.split(/\s*,\s*/).sort : Array(d).sort.map(&:to_s) }
property :remote_address, String
property :remote_port, [String, Integer, Array],
         coerce: proc { |d| d.is_a?(String) ? d.split(/\s*,\s*/).sort : Array(d).sort.map(&:to_s) }
property :direction, [Symbol, String], default: :inbound, equal_to: [:inbound, :outbound],
                                       coerce: proc { |d| d.is_a?(String) ? d.downcase.to_sym : d }
property :protocol, String, default: 'TCP'
property :firewall_action, [Symbol, String], default: :allow, equal_to: [:allow, :block, :notconfigured],
                                             coerce: proc { |f| f.is_a?(String) ? f.downcase.to_sym : f }
property :profile, [Symbol, String], default: :any, equal_to: [:public, :private, :domain, :any, :notapplicable],
                                     coerce: proc { |p| p.is_a?(String) ? p.downcase.to_sym : p }
property :program, String
property :service, String
property :interface_type, [Symbol, String], default: :any, equal_to: [:any, :wireless, :wired, :remoteaccess],
                                            coerce: proc { |i| i.is_a?(String) ? i.downcase.to_sym : i }
property :enabled, [TrueClass, FalseClass], default: true

alias_method :localip, :local_address
alias_method :remoteip, :remote_address
alias_method :localport, :local_port
alias_method :remoteport, :remote_port
alias_method :interfacetype, :interface_type

load_current_value do
  load_state_cmd = load_firewall_state(rule_name)
  output = powershell_out(load_state_cmd)
  if output.stdout.empty?
    current_value_does_not_exist!
  else
    state = Chef::JSONCompat.from_json(output.stdout)
  end
  local_address state['local_address']
  local_port Array(state['local_port']).sort
  remote_address state['remote_address']
  remote_port Array(state['remote_port']).sort
  direction state['direction']
  protocol state['protocol']
  firewall_action state['firewall_action']
  profile state['profile']
  program state['program']
  service state['service']
  interface_type state['interface_type']
  enabled state['enabled']
end

action :create do
  if current_resource
    converge_if_changed :rule_name, :local_address, :local_port, :remote_address, :remote_port, :direction,
                        :protocol, :firewall_action, :profile, :program, :service, :interface_type, :enabled do
      cmd = firewall_command('Set')
      powershell_out!(cmd)
    end
  else
    converge_by("create firewall rule #{new_resource.rule_name}") do
      cmd = firewall_command('New')
      powershell_out!(cmd)
    end
  end
end

action :delete do
  if current_resource
    converge_by("delete firewall rule #{new_resource.rule_name}") do
      powershell_out!("Remove-NetFirewallRule -Name '#{new_resource.rule_name}'")
    end
  else
    Chef::Log.info("Firewall rule \"#{new_resource.rule_name}\" doesn't exist. Skipping.")
  end
end

action_class do
  # build the command to create a firewall rule based on new_resource values
  # @return [String] firewall create command
  def firewall_command(cmdlet_type)
    cmd = "#{cmdlet_type}-NetFirewallRule -Name '#{new_resource.rule_name}'"
    cmd << " -DisplayName '#{new_resource.rule_name}'" if cmdlet_type == 'New'
    cmd << " -Description '#{new_resource.description}'" if new_resource.description
    cmd << " -LocalAddress '#{new_resource.local_address}'" if new_resource.local_address
    cmd << " -LocalPort #{new_resource.local_port.join(',')}" if new_resource.local_port
    cmd << " -RemoteAddress '#{new_resource.remote_address}'" if new_resource.remote_address
    cmd << " -RemotePort #{new_resource.remote_port.join(',')}" if new_resource.remote_port
    cmd << " -Direction '#{new_resource.direction}'" if new_resource.direction
    cmd << " -Protocol '#{new_resource.protocol}'" if new_resource.protocol
    cmd << " -Action '#{new_resource.firewall_action}'" if new_resource.firewall_action
    cmd << " -Profile '#{new_resource.profile}'" if new_resource.profile
    cmd << " -Program '#{new_resource.program}'" if new_resource.program
    cmd << " -Service '#{new_resource.service}'" if new_resource.service
    cmd << " -InterfaceType '#{new_resource.interface_type}'" if new_resource.interface_type
    cmd << " -Enabled '#{new_resource.enabled}'"

    cmd
  end
end

private

# build the command to load the current resource
# # @return [String] current firewall state
def load_firewall_state(rule_name)
  <<-EOH
    Remove-TypeData System.Array # workaround for PS bug here: https://bit.ly/2SRMQ8M
    $rule = Get-NetFirewallRule -Name '#{rule_name}'
    $addressFilter = $rule | Get-NetFirewallAddressFilter
    $portFilter = $rule | Get-NetFirewallPortFilter
    $applicationFilter = $rule | Get-NetFirewallApplicationFilter
    $serviceFilter = $rule | Get-NetFirewallServiceFilter
    $interfaceTypeFilter = $rule | Get-NetFirewallInterfaceTypeFilter
    ([PSCustomObject]@{
      rule_name = $rule.Name
      description = $rule.Description
      local_address = $addressFilter.LocalAddress
      local_port = $portFilter.LocalPort
      remote_address = $addressFilter.RemoteAddress
      remote_port = $portFilter.RemotePort
      direction = $rule.Direction.ToString()
      protocol = $portFilter.Protocol
      firewall_action = $rule.Action.ToString()
      profile = $rule.Profile.ToString()
      program = $applicationFilter.Program
      service = $serviceFilter.Service
      interface_type = $interfaceTypeFilter.InterfaceType.ToString()
      enabled = [bool]::Parse($rule.Enabled.ToString())
    }) | ConvertTo-Json
  EOH
end
