<#
.SYNOPSIS
    Check the status of the Windows Firewall service.

.DESCRIPTION
    This script checks the status of the Windows Firewall service on the local computer. It retrieves the current status of the service and displays it in the console.

.EXAMPLE
    PS C:\> .\Security\Check-FirewallStatus.ps1
    Windows Firewall Service Status: Running

    Press Enter to exit: 

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 29-10-2024
    Version: 1.0
#>

# Get the status of the Windows Firewall service
$firewallStatus = Get-Service -Name "MpsSvc" | Select-Object -ExpandProperty Status

# Display the status of the Windows Firewall service with appropriate color
if ($firewallStatus -eq 'Running') {
    Write-Host "Windows Firewall Service Status: " -NoNewline
    Write-Host "$firewallStatus" -ForegroundColor Green
} else {
    Write-Host "Windows Firewall Service Status: " -NoNewline
    Write-Host "$firewallStatus" -ForegroundColor Red
}

# Prompt user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"
