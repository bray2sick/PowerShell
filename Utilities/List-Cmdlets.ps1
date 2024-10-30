<#
.SYNOPSIS
    Lists all available cmdlets in PowerShell.

.DESCRIPTION
    This script uses the Get-Command cmdlet to retrieve a list of all available cmdlets in PowerShell. The list is sorted alphabetically by cmdlet name.

.EXAMPLE
    PS C:\> .\Utilities\List-cmdlets.ps1

    Name                                        ModuleName
    ----                                        ----------
    Add-AppProvisionedSharedPackageContainer    Dism
    Add-AppSharedPackageContainer               Appx
    Add-AppvClientConnectionGroup               AppvClient
    Add-AppvClientPackage                       AppvClient
    Add-AppvPublishingServer                    AppvClient

    ... (more cmdlets)

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell 

.NOTES
    Author: Braydon Pettit
    Date: 30-10-2024
    Version: 1.0
#>

# Get a list of all available cmdlets
Get-Command -CommandType Cmdlet | Select-Object Name, ModuleName | Sort-Object Name

# Prompt the user to press Enter to exit
Read-Host -Prompt "Press Enter to exit"