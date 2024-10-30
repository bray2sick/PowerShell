<#
.SYNOPSIS
    Performs an NSLookup for the SOA record of a specified domain using a specified DNS server.

.DESCRIPTION
    This script performs an NSLookup for the SOA record of a specified domain using a specified DNS server. The user can choose from a list of predefined DNS servers or enter a custom DNS server IP address. The script then displays the NSLookup results for the specified domain.

.EXAMPLE
    PS C:\> .\Network\Resolve-SOA.ps1
    Select a DNS server:
    
    1. Google (8.8.8.8)
    2. Cloudflare (1.1.1.1)
    3. OpenDNS (208.67.222.222)
    4. Alternate DNS (76.76.19.19)
    5. Quad9 (9.9.9.9)

    Enter the number corresponding to the DNS server: 2

    Enter the domain to lookup: example.com

    Non-authoritative answer:
    google.com
            primary name server = ns1.google.com
            responsible mail addr = dns-admin.google.com
            serial  = 690295798
            refresh = 900 (15 mins)
            retry   = 900 (15 mins)
            expire  = 1800 (30 mins)
            default TTL = 60 (1 min)

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 28-10-2024
    Version: 1.0
#>

param (
    [string]$Domain
)

# Map DNS server options to their respective IP addresses
$dnsServerMap = @{
    1 = "8.8.8.8"        # Google
    2 = "1.1.1.1"        # Cloudflare
    3 = "208.67.222.222" # OpenDNS
    4 = "76.76.19.19"    # Alternate DNS
    5 = "9.9.9.9"        # Quad9
}

try {
    do {
        Write-Host "Select a DNS server:`n"
        Write-Host "1. Google (8.8.8.8)"
        Write-Host "2. Cloudflare (1.1.1.1)"
        Write-Host "3. OpenDNS (208.67.222.222)"
        Write-Host "4. Alternate DNS (76.76.19.19)"
        Write-Host "5. Quad9 (9.9.9.9)"
        $dnsChoice = Read-Host "`nEnter the number corresponding to the DNS server"
    
        if (-not $dnsServerMap.ContainsKey([int]$dnsChoice)) {
            Write-Host "`nInvalid DNS server choice. Please try again.`n" -ForegroundColor Red
        }
    } while (-not $dnsServerMap.ContainsKey([int]$dnsChoice))
    
    $selectedDnsServer = $dnsServerMap[[int]$dnsChoice]
    
    do {
        if (-not $Domain) {
            $Domain = Read-Host "`nEnter the domain to lookup"
        }
    
        if (-not $Domain) {
            Write-Host "`nDomain cannot be empty. Please enter a valid domain." -ForegroundColor Red
        }
    } while (-not $Domain)

    Write-Host " "
    $nslookupResult = nslookup -type=SOA $Domain $selectedDnsServer | Out-String
    Write-Host $nslookupResult
}
catch {
    Write-Host "An error occurred while performing the NSLookup." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
}
        
# Prompt user to press Enter to exit
Read-Host -Prompt "Press Enter to exit"