<#
.SYNOPSIS
    Disables a user account in Active Directory.

.DESCRIPTION
    This script prompts the user to enter the first name and last name of the user account they want to disable. It then checks if the user exists in Active Directory and disables the account if it does. If the user does not exist, an error message is displayed.

.EXAMPLE
    PS C:\> .\ActiveDirectory\Disable-UserAccount.ps1
    Enter the user's first name: Braydon
    Enter the user's last name: Pettit

    User account for Braydon Pettit has been disabled.

    Press Enter to exit:     
      
.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 10-10-2024
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

# Prompt for first name and last name
$firstName = Read-Host "Enter the user's first name"
$lastName = Read-Host "Enter the user's last name"

# Find the user in Active Directory
$user = Get-ADUser -Filter {GivenName -eq $firstName -and Surname -eq $lastName}

if ($user) {
    # Disable the user account
    Disable-ADAccount -Identity $user
    Write-Host "`nUser account for $firstName $lastName has been disabled." -ForegroundColor Green
} else {
    Write-Host "`nUser $firstName $lastName not found in Active Directory." -ForegroundColor Red
}

# Prevent the script from closing automatically
Read-Host -Prompt "`nPress Enter to exit"