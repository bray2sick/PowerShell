<#
.SYNOPSIS
    Disables or enables a user account in Active Directory.

.DESCRIPTION
    This script prompts the user to enter the first name and last name of the user account they want to disable or enable. It then checks if the user exists in Active Directory and performs the specified action. If the user does not exist, an error message is displayed.

.EXAMPLE
    PS C:\> .\ActiveDirectory\EnableDisable-UserAccount.ps1
    Do you want to (E)nable or (D)isable a user account? (E/D):

    Enter the user's first name: Braydon
    Enter the user's last name: Pettit

    User account for Braydon Pettit has been enabled.

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

# Prompt for the action to take
$action = Read-Host "Do you want to (E)nable or (D)isable a user account? (E/D)"

# Prompt for first name and last name
$firstName = Read-Host "`nEnter the user's first name"
$lastName = Read-Host "Enter the user's last name"

# Find the user in Active Directory
$user = Get-ADUser -Filter {GivenName -eq $firstName -and Surname -eq $lastName}

if ($user) {
    switch ($action.ToUpper()) {
        'E' {
            # Enable the user account
            Enable-ADAccount -Identity $user
            Write-Host "`nUser account for $firstName $lastName has been enabled." -ForegroundColor Green
        }
        'D' {
            # Disable the user account
            Disable-ADAccount -Identity $user
            Write-Host "`nUser account for $firstName $lastName has been disabled." -ForegroundColor Green
        }
        default {
            Write-Host "`nInvalid option. Please enter 'E' to enable or 'D' to disable." -ForegroundColor Red
        }
    }
} else {
    Write-Host "`nUser $firstName $lastName not found in Active Directory." -ForegroundColor Red
}

# Prevent the script from closing automatically
Read-Host -Prompt "`nPress Enter to exit"
