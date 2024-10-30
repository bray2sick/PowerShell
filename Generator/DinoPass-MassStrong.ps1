<#
.SYNOPSIS
    Generates strong passwords using the DinoPass API and saves them to a CSV file.

.DESCRIPTION
    This script generates strong passwords using the DinoPass API and continuously saves them to a CSV file in the "Log/DinoPass" folder in the root directory. The passwords are retrieved from the API and saved to the CSV file in real-time. The script uses the Get-StrongPassword function to retrieve passwords from the DinoPass API and saves them to the CSV file. The script runs indefinitely until it is stopped manually.

.EXAMPLE
    PS C:\> .\Generator\DinoPass-MassStrong.ps1
    Do you want to save the passwords to a CSV file? (Y/N): Y

    $hinyHill39
    $carySmoke24
    uglyD3er65
    b!gOlive45
    ... (continues generating passwords)

    Passwords saved to C:\PowerShell Scripts\Logs\DinoPass\Passwords_29-10-2024_12-11-31.csv

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 29-10-2024
    Version: 1.0
#>

# Function to retrieve a strong password from the DinoPass API
function Get-StrongPassword {
    $url = "https://www.dinopass.com/password/strong"
    try {
        $response = Invoke-RestMethod -Uri $url -Method Get
        return $response
    } catch {
        Write-Error "Failed to retrieve password from DinoPass API: $_"
        return $null
    }
}

# Array to store generated passwords
$passwords = @()

# Ask the user if they want to save the passwords to a CSV file
$saveToCsv = Read-Host "Do you want to save the passwords to a CSV file? (Y/N)"
Write-Host " "
if ($saveToCsv -eq 'Y' -or $saveToCsv -eq 'y') {
    # Define the path to the "Logs/DinoPass" folder
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $rootDir = Split-Path -Parent $scriptDir
    $passwordsDir = Join-Path -Path $rootDir -ChildPath "Log/DinoPass"

    # Create the "Logs/DinoPass" folder if it doesn't exist
    if (-not (Test-Path -Path $passwordsDir)) {
        New-Item -ItemType Directory -Path $passwordsDir | Out-Null
    }

    # Define the path for the CSV file
    $csvFile = Join-Path -Path $passwordsDir -ChildPath ("Passwords_{0:dd-MM-yyyy_HH-mm-ss}.csv" -f (Get-Date))
}

# Continuously generate passwords until the script is stopped
try {
    while ($true) {
        $password = Get-StrongPassword
        if ($password) {
            Write-Output "$password"
            $passwords += $password
        } else {
            Write-Output "Failed to generate a strong password."
        }
        Start-Sleep -Seconds 1  # Optional: Add a delay between requests
    }
} catch {
    Write-Error "An error occurred: $_"
} finally {
    if ($saveToCsv -eq 'Y' -or $saveToCsv -eq 'y') {
        # Save the passwords to the CSV file
        $passwords | ForEach-Object { [PSCustomObject]@{Password=$_} } | Export-Csv -Path $csvFile -NoTypeInformation

        # Inform the user
        Write-Host "`nPasswords saved to $csvFile`n"
    }
}