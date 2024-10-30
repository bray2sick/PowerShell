<#
.SYNOPSIS
    Pings a target and displays the results.

.DESCRIPTION
    This script pings a target and displays the results. The user can enter a website or IP address to ping, and the script will display the ping results. The user can choose to ping another target or exit the script.

.EXAMPLE
    PS C:\> .\Network\Ping-Check.ps1
    Enter the website or IP address to ping: google.com

    Ping results for google.com:
    Pinging google.com [142.250.70.238] with 32 bytes of data:
    Reply from 142.250.70.238: bytes=32 time=14ms TTL=58
    Reply from 142.250.70.238: bytes=32 time=14ms TTL=58
    Reply from 142.250.70.238: bytes=32 time=14ms TTL=58
    Reply from 142.250.70.238: bytes=32 time=13ms TTL=58

    Ping statistics for 142.250.70.238:
        Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
    Approximate round trip times in milli-seconds:
        Minimum = 13ms, Maximum = 14ms, Average = 13ms
        
    Do you want to ping another target? (y/n):

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 15-10-2024
    Version: 1.0
#>

param (
    [string]$Target
)

while ($true) {
    if (-not $Target) {
        $Target = Read-Host "Enter the website or IP address to ping"
    }

    try {
        $pingResult = & ping.exe $Target | Out-String
        if ($pingResult -match "Ping request could not find host") {
            throw "Ping request could not find host $Target. Please check the name and try again.`n"
        }

        $pingLines = $pingResult -split "`r?`n"
        Write-Host "`nPing results for ${Target}:" -ForegroundColor Green
        foreach ($line in $pingLines) {
            Write-Host $line
        }
    }
    catch {
        Write-Host "`nPing results for ${Target}:" -ForegroundColor Green
        Write-Host ""
        Write-Host $_ -ForegroundColor Red
    }

    $continue = Read-Host "Do you want to ping another target? (y/n)"
    if ($continue -ne 'y') {
        break
    }

    Write-Host "" 
    $Target = $null 
}