<#
.SYNOPSIS
    Retrieves and displays a list of installed software on the system.

.DESCRIPTION
    This script retrieves a list of installed software on the system using the 'Get-WmiObject' cmdlet and displays it in a table format.

.EXAMPLE
    PS C:\> .\System\Get-InstalledSoftware.ps1

    Name                                                           Version          InstallDate
    ----                                                           -------          -----------
    Microsoft Teams Meeting Add-in for Microsoft Office            1.24.25506       20241017
    Office 16 Click-to-Run Extensibility Component                 16.0.18025.20126 20241013
    Office 16 Click-to-Run Licensing Component                     16.0.18025.20160 20241020
    AMD Ryzen Balanced Driver                                      8.0.0.13         20240816
    Windows SDK for Windows Store Apps Metadata                    10.1.19041.685   20241007

    ... (more entries)

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 15-10-2024
    Version: 1.0
#>

# Get a list of installed software on the system
$installedSoftware = Get-WmiObject -Class Win32_Product | Select-Object -Property Name, Version, InstallDate

# Display the list of installed software in a table format
$installedSoftware | Format-Table -AutoSize

# Prompt user to press Enter to exit
Read-Host -Prompt "Press Enter to exit"
