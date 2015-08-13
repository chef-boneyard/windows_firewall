$allowrule = Get-NetFirewallRule | where {($_.DisplayName -eq "Apache") -and ($_.Action -eq "Allow")}
$allowports = $allowrule | Get-NetFirewallPortFilter
$allowaddresses = $allowrule | Get-NetFirewallAddressFilter
$allowprograms = $allowrule | Get-NetFirewallApplicationFilter

$blockrule = Get-NetFirewallRule | where {($_.DisplayName -eq "Disable WinRM over HTTP")  -and ($_.Action -eq "Block")}
$blockports = $blockrule | Get-NetFirewallPortFilter
$blockaddresses = $blockrule | Get-NetFirewallAddressFilter
$blockprograms = $blockrule | Get-NetFirewallApplicationFilter

Describe "Apache Firewall Rule" {
    It "exists" {
       $allowrule | Should Not BeNullOrEmpty
    }
    It "has the right port" {
      $allowports.LocalPort | Should Be '8080'
    }
    It "has the right protocol" {
      $allowports.Protocol | Should Be 'TCP'
    }
    It "has the right local address" {
      $allowaddresses.LocalAddress | Should Be '192.168.1.1'
    }
    It "has the right program listed" {
      $allowprograms.program | Should Be 'c:\program files\test.exe'
    }
}

Describe "WinRM Firewall Rule" {
    It "exists" {
       $blockrule | Should Not BeNullOrEmpty
    }
    It "has the right port" {
      $blockports.LocalPort | Should Be '5985'
    }
    It "has the right protocol" {
      $blockports.Protocol | Should Be 'TCP'
    }
    It "has the right local address" {
      $blockaddresses.LocalAddress | Should Be '192.168.1.1'
    }
    It "has the right program listed" {
      $blockprograms.program | Should Be 'c:\program files\test.exe'
    }
}
