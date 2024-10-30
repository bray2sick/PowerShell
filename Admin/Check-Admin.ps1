<#
.SYNOPSIS
    This script checks if the current user has administrative privileges on the local system by listing the members of the local Administrators group.

.DESCRIPTION
    This script lists all members of the local Administrators group on the system. If the current user is a member of this group, they have administrative privileges on the system.

.EXAMPLE
    PS C:\> .\Admin\Check-Admin.ps1
    Administrator
    User
    
    Press Enter to exit:

.LINK 
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 24-10-2024
    Version: 1.0
#>

# Get the local administrators group
$adminGroup = [ADSI]"WinNT://./Administrators,group"

# List all members of the local administrators group
$adminGroup.Members() | ForEach-Object { $_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null) }

# Prompt user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"
