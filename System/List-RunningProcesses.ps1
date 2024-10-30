<#
.SYNOPSIS
    List all running processes on the system.

.DESCRIPTION
    This script retrieves information about all running processes on the system and displays it in a table. The information includes the process name, ID, CPU usage, and start time.   

.EXAMPLE
    C:\> .\System\List-RunningProcesses.ps1
    Name                           Id         CPU StartTime
    ----                           --         --- ---------
    AcrobatNotificationClient   12864    0.203125 25/10/2024 6:29:24 PM
    Adobe Crash Processor       18968    0.953125 25/10/2024 6:29:20 PM
    Adobe Desktop Service       19132   29.484375 25/10/2024 6:29:21 PM
    AdobeCollabSync              9556      0.0625 25/10/2024 6:29:19 PM

    ... (more processes)

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 29-10-2024
    Version: 1.0
#>

#  Output a message indicating that the script is loading running processes
Write-Host "Loading running processes..."

# Get all running processes and select the required properties
Get-Process | Select-Object Name, Id, CPU, StartTime | Format-Table -AutoSize

# Prompt user to press Enter to exit
Read-Host -Prompt "Press Enter to exit"