<#
.SYNOPSIS
    List all security groups in the Active Directory.

.DESCRIPTION
    This script retrieves a list of all security groups in the Active Directory and displays information such as the group name, scope, and category.

.EXAMPLE
    PS C:\> .\ActiveDirectory\List-SecurityGroups.ps1

    Name                                     GroupScope GroupCategory
    ----                                     ---------- -------------
    Administrators                          DomainLocal      Security
    Users                                   DomainLocal      Security
    Guests                                  DomainLocal      Security

    ... (more groups)

    Press Enter to exit:
.LINK
    https://github.com/bray2sick/PowerShell 

.NOTES
    Author: Braydon Pettit
    Date: 30-10-2024
    Version: 1.0
#>

# Import the Active Directory module
Import-Module ActiveDirectory  

# Get a list of all security groups in the Active Directory
Get-ADGroup -Filter * | Select-Object Name, GroupScope, GroupCategory

# Prompt the user to press Enter to exit
Read-Host -Prompt "Press Enter to exit"
