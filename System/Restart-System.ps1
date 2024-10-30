<#
.SYNOPSIS
    Restarts the system.

.DESCRIPTION
    This script restarts the system after prompting the user for confirmation.

.EXAMPLE
    PS C:\> .\System\Restart-System.ps1
    Are you sure you want to restart the system? (Y/N): Y

    ...(system restarts)

.LINK
    https://github.com/bray2sick/PowerShell
    
.NOTES
    Author: Braydon Pettit
    Date: 30-10-2024
    Version: 1.0
#>

# Prompt the user for confirmation
$confirmation = Read-Host "Are you sure you want to restart the system? (Y/N)"

# Restart the system if the user confirms
if ($confirmation -eq 'Y' -or $confirmation -eq 'y') {
    # Restart the system
    Restart-Computer -Force
} else {
    Write-Host "System restart canceled."
}