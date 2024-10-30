<#
.SYNOPSIS
    Opens the Network Connections section in Control Panel.

.DESCRIPTION
    This script opens the Network Connections section in Control Panel using the 'ncpa.cpl' command.

.EXAMPLE
    PS C:\> .\System\Open-NetworkConnections.ps1

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 29-10-2024
    Version: 1.0
#>

# Open the Network Connections section in Control Panel
Start-Process "ncpa.cpl"