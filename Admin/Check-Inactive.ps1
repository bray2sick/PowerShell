<#
.SYNOPSIS
    Check for inactive local user accounts.

.DESCRIPTION
    This script retrieves a list of local user accounts on the computer and checks for accounts that have not logged in within the last 90 days or have never logged in. The script displays the name of the account and the last logon time.

.EXAMPLE
    PS C:\> .\Admin\Check-Inactive.ps1

    Name               LastLogon
    ----               ---------
    Administrator
    Guest
    Braydon      
    User     

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell 

.NOTES
    Author: Braydon Pettit
    Date: 30-10-2024
    Version: 1.0
#>

# Get a list of local user accounts and check for inactivity within the last 90 days
$days = 90
$cutoff = (Get-Date).AddDays(-$days)
Get-LocalUser | Where-Object { $_.LastLogon -lt $cutoff -or -not $_.LastLogon } | Select-Object Name, LastLogon

# Prompt the user to press Enter to exit
Read-Host -Prompt "Press Enter to exit"
