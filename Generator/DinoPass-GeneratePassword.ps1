<#
.SYNOPSIS
    Generate strong passwords using the DinoPass API.

.DESCRIPTION
    This script generates strong passwords using the DinoPass API and displays them to the user. The Get-StrongPassword function is used to retrieve passwords from the DinoPass API. The user can choose to generate multiple passwords in a loop until they decide to stop.

.EXAMPLE
    PS C:\> .\Generator\DinoPass-GeneratePassword.ps1
    Do you want to generate a password? (Y/N): Y

    Generated Password: =irstGate63

    Do you want to generate another password? (Y/N): Y

    Generated Password: ro$eBall10

    Do you want to generate another password? (Y/N): N

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 29-10-2024
    Version: 1.0
#>
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

$userInput = Read-Host "Do you want to generate a password? (Y/N)"
while ($userInput -eq 'Y' -or $userInput -eq 'y') {
    $password = Get-StrongPassword
    if ($password) {
        Write-Output "`nGenerated Password: $password"
    }

    $userInput = Read-Host "`nDo you want to generate another password? (Y/N)"
}