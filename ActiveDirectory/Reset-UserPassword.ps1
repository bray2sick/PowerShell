<#
.SYNOPSIS
    Resets the password for a user account in Active Directory and requires the user to change it at first login.

.DESCRIPTION
    This script prompts the user to enter the first name and last name of the user account they want to reset the password for. It then checks if the user exists in Active Directory, resets the password if it does, and sets the account to require a password change at the next login.

.EXAMPLE
    PS C:\> .\ActiveDirectory\Reset-UserPassword.ps1
    Enter the user's first name: Braydon
    Enter the user's last name: Pettit
    
    Enter the new password: ********
    
    Password for Braydon Pettit has been reset and the user is required to change it at next login.

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 10-10-2024
    Version: 1.1
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

# Prompt for first name, last name, and new password
$firstName = Read-Host "Enter the user's first name"
$lastName = Read-Host "Enter the user's last name"
$newPassword = Read-Host "Enter the new password" -AsSecureString

# Find the user in Active Directory
$user = Get-ADUser -Filter {GivenName -eq $firstName -and Surname -eq $lastName}
if ($user) {
    # Reset the user password
    Set-ADAccountPassword -Identity $user -NewPassword $newPassword -Reset
    # Require the user to change the password at next login
    Set-ADUser -Identity $user -ChangePasswordAtLogon $true
    Write-Host "`The password for $firstName $lastName has been reset. They will need to change it during their next login." -ForegroundColor Green
} else {
    Write-Host "`nUser $firstName $lastName not found in Active Directory." -ForegroundColor Red
}

# Prevent the script from closing automatically
Read-Host -Prompt "`nPress Enter to exit"