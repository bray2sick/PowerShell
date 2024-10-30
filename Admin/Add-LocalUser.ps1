<#
.SYNOPSIS
    This script creates a new local user account on the system.

.DESCRIPTION
    This script prompts the user to enter a username and password for the new account. It then checks if the username is already in use on the system. If the username is available, a new local user account is created with the specified username and password.
.EXAMPLE
    PS C:\> .\Admin\Add-LocalUser.ps1
    Enter the username: Braydon
    Enter the password: ********

    User Braydon has been created.

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 24-10-2024
    Version: 1.0
#>

do {
    # Prompt for username
    $username = Read-Host -Prompt 'Enter a username'

    # Check if the user already exists
    if (Get-LocalUser -Name $username -ErrorAction SilentlyContinue) {
        Write-Host "`nUser " -NoNewline
        Write-Host $username -ForegroundColor Red -NoNewline
        Write-Host " already exists... Please try again.`n"
    }
    else {
        $validPassword = $false

        while (-not $validPassword) {
            # Prompt for password
            $password = Read-Host -Prompt 'Enter a password' -AsSecureString
            
            try {
                # Attempt to create the local user
                New-LocalUser -Name $username -Password $password -PasswordNeverExpires:$true -UserMayNotChangePassword:$false -ErrorAction Stop
                Write-Host "`nUser " -NoNewline
                Write-Host $username -ForegroundColor Green -NoNewline
                Write-Host " has been created."
                $validPassword = $true  # Exit the password loop
            } catch {
                Write-Host " "
                Write-Host $_.Exception.Message -ForegroundColor Red
            }
        }
        break
    }
} while ($true)

# Prompt user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"
