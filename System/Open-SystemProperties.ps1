<#
.SYNOPSIS
    Opens the "System Properties" window in Windows.

.DESCRIPTION
    This script opens the "System Properties" window in Windows. The "System Properties" window allows you to view and change system settings such as the computer name, domain, and workgroup settings, as well as the hardware and performance settings.

.EXAMPLE
    PS C:\> ..\System\Open-SystemProperties.ps1

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 28-10-2024
    Version: 1.0
#>

# Open the "System Properties" window
Start-Process "SystemPropertiesComputerName.exe"