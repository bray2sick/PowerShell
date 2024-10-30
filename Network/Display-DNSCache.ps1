<#
.SYNOPSIS
    Displays the DNS cache.

.DESCRIPTION
    This script retrieves and displays the DNS cache using the ipconfig /displaydns command.

.EXAMPLE
    PS C:\> .\Network\Display-DNSCache.ps1

    Windows IP Configuration

        www.example.com
        ----------------------------------------
        Record Name . . . . . : www.example.com
        Record Type . . . . . : 1
        Time To Live  . . . . : 120
        Data Length . . . . . : 4
        Section . . . . . . . : Answer
        A (Host) Record . . . : 93.184.216.34

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 28-10-2024
    Version: 1.0
#>

try {
    # Retrieve the DNS cache
    $dnsCache = & ipconfig /displaydns | Out-String
    Write-Host $dnsCache
}
catch {
    # Display an error message if an exception occurs
    Write-Host "An error occurred while retrieving the DNS cache." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
}

# Prompt user to press Enter to exit
Read-Host -Prompt "Press Enter to exit"