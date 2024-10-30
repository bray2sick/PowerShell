<#
.SYNOPSIS
    This script retrieves information about the system uptime and displays it in a human-readable format.

.DESCRIPTION
    This script uses the 'Get-CimInstance' cmdlet to retrieve the last boot up time of the system. It then calculates the duration of the system uptime and displays it in a human-readable format.

.EXAMPLE
    PS C:\> .\System\Get-SystemUptime.ps1
    System Uptime: 1 days, 22 hours, 7 minutes, 48 seconds

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 15-10-2024
    Version: 1.0
#>

# Get the system uptime
$uptime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime

# Calculate the uptime duration
$uptimeDuration = (Get-Date) - $uptime

# Output the uptime duration
Write-Output "System Uptime: $($uptimeDuration.Days) days, $($uptimeDuration.Hours) hours, $($uptimeDuration.Minutes) minutes, $($uptimeDuration.Seconds) seconds"

# Prompt user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"