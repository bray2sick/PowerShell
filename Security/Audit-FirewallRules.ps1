<#
.SYNOPSIS
    Audit the Windows Firewall rules on a computer.

.DESCRIPTION
    This script retrieves and displays the Windows Firewall rules on a computer using the Get-NetFirewallRule cmdlet. The output includes the name, enabled status, action, and direction of each rule.

.EXAMPLE
    PS C:\> .\Security\Audit-FirewallRules.ps1
    
.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 30-10-2024
    Version: 1.0
#>

# Get a list of all Windows Firewall rules
Get-NetFirewallRule | Select-Object Name, Enabled, Action, Direction

# Prompt the user to press Enter to exit
Read-Host -Prompt "Press Enter to exit"
