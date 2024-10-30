<#
.SYNOPSIS
    This script removes a local user account from the system.

.DESCRIPTION
    This script prompts the user to enter the username of the account they want to remove. It then checks if any user exists on the system with the inputted name and removes the account if it does. If no user exists, an error message is displayed and the user is prompted to try again.

.EXAMPLE
    PS C:\> .\Admin\Remove-LocalUser.ps1
    Enter the username to remove: Braydon

    User Braydon has been removed.

    Press Enter to exit:

.LINK  
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 24-10-2024
    Version: 1.1
#>

do {
    # Prompt for username
    $username = Read-Host -Prompt 'Enter the username to remove'

    # Retrieve all local users and check if any user exists with the inputted name
    $user = Get-LocalUser | Where-Object { $_.Name -eq $username }

    if ($user) {
        # Remove the user
        Remove-LocalUser -Name $username
        Write-Host "`nUser " -NoNewline
        Write-Host $username -ForegroundColor Green -NoNewline
        Write-Host " has been removed."
        $userExists = $true
    }
    else {
        # Display an error message if no user exists with the inputted name
        Write-Host "`nUser " -NoNewline
        Write-Host $username -ForegroundColor Red -NoNewline
        Write-Host " does not exist... Please try again.`n"
        $userExists = $false
    }
} while (-not $userExists)

# Prompt user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"