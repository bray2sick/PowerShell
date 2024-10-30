<#
.SYNOPSIS
    This script retrieves the public IP address of the machine using the ipify API.

.DESCRIPTION
    This script retrieves the public IP address of the machine using the ipify API. The public IP address is displayed to the user.

.EXAMPLE
    PS C:\> .\Network\Check-PublicIP.ps1

    Your public IP address is: 127.0.0.1

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell 

.NOTES
    Author: Braydon Pettit
    Date: 30-10-2024
    Version: 1.0
#>

# Function to get the public IP address
function Get-PublicIP {
    try {
        $publicIP = Invoke-RestMethod -Uri "https://api.ipify.org?format=json"
        return $publicIP.ip
    } catch {
        Write-Error "Failed to retrieve public IP address: $_"
        Read-Host -Prompt "`nPress Enter to exit"
    }
}

# Main script execution
$publicIP = Get-PublicIP
if ($publicIP) {
    Write-Output "Your public IP address is: $publicIP"
    Read-Host -Prompt "`nPress Enter to exit"
} else {
    Write-Output "Unable to determine public IP address."
    Read-Host -Prompt "`nPress Enter to exit"
}