$rule = Get-NetFirewallRule | where DisplayName -eq "Apache"
$ports = $rule | Get-NetFirewallPortFilter
$addresses = $rule | Get-NetFirewallAddressFilter
$programs = $rule | Get-NetFirewallApplicationFilter

Describe "Apache Firewall Rule" {
    It "exists" {
       $rule | Should Not BeNullOrEmpty
    }
    It "has the right port" {
      $ports.LocalPort | Should Be '8080'
    }
    It "has the right protocol" {
      $ports.Protocol | Should Be 'TCP'
    }
    It "has the right local address" {
      $addresses.LocalAddress | Should Be '192.168.1.1'
    }
    It "has the right program listed" {
      $programs.program | Should Be 'c:\program files\test.exe'
    }
}