<#
.SYNOPSIS
    Runs Disk Clean-up for a specified drive.

.DESCRIPTION
    This script prompts the user to enter a drive letter (e.g., C) and then runs Disk Clean-up for the specified drive using the 'cleanmgr.exe' utility.

    .EXAMPLE
    PS C:\> .\System\Open-DiskCleanUp.ps1
    Please enter the drive letter (e.g., C): C

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 29-10-2024
    Version: 1.0
#>

# Function to prompt for drive letter and validate input
function Get-ValidDriveLetter {
    while ($true) {
        $driveLetter = Read-Host "Please enter a drive letter (e.g., C)"
        if ($driveLetter -match '^[A-Z]$') {
            return "${driveLetter}:"
        } else {
            Write-Host "`nInvalid drive letter. Please enter a valid drive letter (e.g., C).`n"
        }
    }
}

# Get a valid drive letter from the user
$driveLetter = Get-ValidDriveLetter

# Run Disk Clean-up for the specified drive
Start-Process -FilePath "cleanmgr.exe" -ArgumentList "/d", $driveLetter