<#
.SYNOPSIS
    This script checks the Wi-Fi signal strength of the active Wi-Fi adapter.

.DESCRIPTION
    This script retrieves the Wi-Fi signal strength of the active Wi-Fi adapter on the system. It uses the 'netsh wlan show interfaces' command to get the signal strength information and displays it in the console.

.EXAMPLE
    PS C:\> .\Network\Check-WiFiSignalStrength.ps1
    No active Wi-Fi adapter found.

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 24-10-2024
    Version: 1.0
#>


# Get the Wi-Fi adapter's status and details
$wifiAdapter = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' -and $_.NdisPhysicalMedium -eq '802.11' }

if ($wifiAdapter) {
    # Get the Wi-Fi signal strength using netsh command
    $signalStrength = netsh wlan show interfaces | Select-String -Pattern 'Signal'

    # Output the result
    if ($signalStrength) {
        $signalStrength -replace '.*: ', ''
    } else {
        # If signal strength not found
        "Wi-Fi signal strength not found."
    }
} else {
    # If no active Wi-Fi adapter found
    "`nNo active Wi-Fi adapter found."
}

# Prompt user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"

