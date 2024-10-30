<#
.SYNOPSIS
    Deletes a user account from Active Directory.

.DESCRIPTION
    This script prompts the user to enter the first name and last name of the user account they want to delete. It then checks if the user exists in Active Directory and deletes the account if it does. If the user does not exist, an error message is displayed.

.EXAMPLE
    PS C:\> .\ActiveDirectory\Delete-UserAccount.ps1
    Enter the first name of the user to delete: Braydon
    Enter the last name of the user to delete: Pettit

    User Braydon Pettit has been deleted from Active Directory.

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

# Prompt for the user's first name and last name
$firstName = Read-Host -Prompt 'Enter the first name of the user to delete'
$lastName = Read-Host -Prompt 'Enter the last name of the user to delete'

# Find the user in Active Directory
$user = Get-ADUser -Filter {GivenName -eq $firstName -and Surname -eq $lastName}

if ($user) {
    # Delete the user
    Remove-ADUser -Identity $user -Confirm:$false
    Write-Host "`nUser $firstName $lastName has been deleted from Active Directory." -ForegroundColor Green
} else {
    Write-Host "`nUser $firstName $lastName not found in Active Directory." -ForegroundColor Red
}

# Prevent the script from closing automatically
Read-Host -Prompt "`nPress Enter to exit"