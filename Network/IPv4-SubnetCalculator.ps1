<#
.SYNOPSIS
    This script calculates network address, broadcast address, usable IP range, and number of usable hosts in a subnet.

.DESCRIPTION
    This script takes an IPv4 address and subnet mask as input and calculates the network address, broadcast address, usable IP range, and number of usable hosts in the subnet. It uses bitwise operations to perform the calculations and outputs the results to the console.

    .EXAMPLE
    PS C:\> .\Network\IPCalculator.ps1
    Enter IP Address: 192.168.0.10    
    Enter Subnet Mask: 255.255.255.0 

    IP Address: 192.168.0.10
    Network Address: 192.168.0.0
    Broadcast Address: 192.168.0.255
    Usable IP Range: 192.168.0.1 - 192.168.0.254
    Number of Usable Hosts: 254
    Total Number of Hosts: 256

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 29-10-2024
    Version: 1.0
#>
function Get-NetworkAddress {
    param (
        [string]$ipAddress,
        [string]$subnetMask
    )
    $ip = [System.Net.IPAddress]::Parse($ipAddress)
    $mask = [System.Net.IPAddress]::Parse($subnetMask)
    $ipBytes = $ip.GetAddressBytes()
    $maskBytes = $mask.GetAddressBytes()
    $networkBytes = @()
    for ($i = 0; $i -lt $ipBytes.Length; $i++) {
        $networkBytes += $ipBytes[$i] -band $maskBytes[$i]
    }
    return [System.Net.IPAddress]::new($networkBytes)
}

# Calculate the broadcast address in a subnet
function Get-BroadcastAddress {
    param (
        [string]$ipAddress,
        [string]$subnetMask
    )
    $ip = [System.Net.IPAddress]::Parse($ipAddress)
    $mask = [System.Net.IPAddress]::Parse($subnetMask)
    $ipBytes = $ip.GetAddressBytes()
    $maskBytes = $mask.GetAddressBytes()
    $broadcastBytes = @()
    for ($i = 0; $i -lt $ipBytes.Length; $i++) {
        $broadcastBytes += $ipBytes[$i] -bor (-bnot $maskBytes[$i] -band 0xFF)
    }
    return [System.Net.IPAddress]::new($broadcastBytes)
}

# Calculate the usable IP range in a subnet
function Get-UsableIPRange {
    param (
        [string]$networkAddress,
        [string]$broadcastAddress
    )
    $network = [System.Net.IPAddress]::Parse($networkAddress)
    $broadcast = [System.Net.IPAddress]::Parse($broadcastAddress)
    $networkBytes = $network.GetAddressBytes()
    $broadcastBytes = $broadcast.GetAddressBytes()
    $networkBytes[3] += 1
    $broadcastBytes[3] -= 1
    $firstUsable = [System.Net.IPAddress]::new($networkBytes)
    $lastUsable = [System.Net.IPAddress]::new($broadcastBytes)
    return @($firstUsable, $lastUsable)
}

# Calculate the total number of hosts in a subnet
function Get-TotalHostsCount {
    param (
        [string]$subnetMask
    )
    $mask = [System.Net.IPAddress]::Parse($subnetMask)
    $maskBytes = $mask.GetAddressBytes()
    $hostBits = 0
    foreach ($byte in $maskBytes) {
        $hostBits += [Convert]::ToString($byte, 2).PadLeft(8, '0').Replace('1', '').Length
    }
    return [math]::Pow(2, $hostBits)
}

# Calculate the number of usable hosts in a subnet
function Get-UsableHostsCount {
    param (
        [string]$subnetMask
    )
    $totalHosts = Get-TotalHostsCount -subnetMask $subnetMask
    return $totalHosts - 2
}

function Main {

    # Prompt user for IP address and subnet mask
    $ipAddress = Read-Host "Enter IP Address"
    $subnetMask = Read-Host "Enter Subnet Mask"
    
    # Calculate network address, broadcast address, usable IP range, and number of usable hosts
    $networkAddress = Get-NetworkAddress -ipAddress $ipAddress -subnetMask $subnetMask
    $broadcastAddress = Get-BroadcastAddress -ipAddress $ipAddress -subnetMask $subnetMask
    $usableRange = Get-UsableIPRange -networkAddress $networkAddress -broadcastAddress $broadcastAddress
    $usableHostsCount = Get-UsableHostsCount -subnetMask $subnetMask
    $totalHostsCount = Get-TotalHostsCount -subnetMask $subnetMask
    
    # Output the results
    Write-Output "`nIP Address: $ipAddress"
    Write-Output "Network Address: $networkAddress"
    Write-Output "Broadcast Address: $broadcastAddress"
    Write-Output "Usable IP Range: $($usableRange[0]) - $($usableRange[1])"
    Write-Output "Number of Usable Hosts: $usableHostsCount"
    Write-Output "Total Number of Hosts: $totalHostsCount"
}

# Call the Main function
Main

# Prompt user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"