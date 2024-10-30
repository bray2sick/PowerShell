<#
.SYNOPSIS
    Check for pending Windows updates on the local machine.

.DESCRIPTION
    This script checks for pending Windows updates on the local machine. It retrieves the list of pending updates and displays them in the console.

.EXAMPLE
    PS C:\> .\Security\Check-WindowsUpdates.ps1
    Checking for Windows updates...

    Pending Updates:
    - Update for Windows 10 Version 21H1 (KB5004237)
    - Security Update for Adobe Flash Player (KB5004331)

    Press Enter to exit: 

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 29-10-2024
    Version: 1.0
#>

# Display message indicating the script is checking for updates
Write-Host "Checking for Windows updates..."

# Get the list of pending Windows updates
$updates = New-Object -ComObject Microsoft.Update.Session
$searcher = $updates.CreateUpdateSearcher()
$searchResult = $searcher.Search("IsInstalled=0")

# Display the list of pending updates
if ($searchResult.Updates.Count -eq 0) {
    Write-Host "No pending updates found."
} else {
    Write-Host "`nPending Updates:"
    foreach ($update in $searchResult.Updates) {
        Write-Host "- $($update.Title)"
    }
}

# Prompt user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"