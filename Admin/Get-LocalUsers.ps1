<#
.SYNOPSIS
    Retrieves information about local users and displays it in a table. 

.DESCRIPTION
    This script retrieves information about local users on the system and displays it in a table. The information includes the user's name, full name, and last logon time.
.EXAMPLE
    PS C:\> .\Admin\Get-LocalUsers.ps1
    Name               FullName LastLogon
    ----               -------- ---------
    Administrator                
    User               User     28/10/2024 4:30:00 PM
    Guest

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 15-10-2024
    Version: 1.0
#>

# Retrieve information about local users
Get-LocalUser | Format-Table -Property Name,FullName,LastLogon

# Prompt user to press Enter to exit
Read-Host -Prompt "Press Enter to exit"