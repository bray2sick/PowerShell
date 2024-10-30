<#
.SYNOPSIS
    This script retrieves the last logon time for a specified user in Active Directory. 

.DESCRIPTION
    This script prompts the user to enter the first name and last name of the user. It then searches Active Directory for the user based on the given first and last name. If the user is found, the script retrieves the last logon time for the user and displays it in a human-readable format. If the last logon time is not available, the script informs the user that the information is not available. Note that this script can only be run on a server.

.EXAMPLE
    PS C:\> .\ActiveDirectory\GetUserLastLogonTime.ps1
    Enter the user's first name: John
    Enter the user's last name: Doe 

    Last logon time for John Doe: 29/10/2024 10:41:00 AM

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 29-10-2024
    Version: 1.0
#>

# Import the Active Directory module
Import-Module ActiveDirectory -ErrorAction SilentlyContinue

# Check if the script is running on a server
$os = Get-WmiObject Win32_OperatingSystem
if ($os.ProductType -eq 1) {
    Write-Host "This script can only be run on a server." -ForegroundColor Red
    Read-Host -Prompt "`nPress Enter to exit"
    exit
}

# Prompt for first and last name
$firstName = Read-Host "Enter the user's first name"
$lastName = Read-Host "Enter the user's last name"

# Search for the user in Active Directory
$user = Get-ADUser -Filter { GivenName -eq $firstName -and Surname -eq $lastName } -Properties LastLogon

if ($user) {
    if ($user.LastLogon) {
        # Convert LastLogon to readable format
        $lastLogon = [DateTime]::FromFileTime($user.LastLogon)
        Write-Host "Last logon time for $($user.Name): $lastLogon"
    } else {
        Write-Host "Last logon time for $($user.Name) is not available."
    }
} else {
    Write-Host "`nUser not found." -ForegroundColor Red
}

# Prevent the script from closing automatically
Read-Host -Prompt "`nPress Enter to exit"