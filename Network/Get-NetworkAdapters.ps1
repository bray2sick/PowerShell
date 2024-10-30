<#
.SYNOPSIS
    Get network adapters on the local computer.

.DESCRIPTION
    This script retrieves information about network adapters on the local computer, including the name, description, status, MAC address, and link speed.

.EXAMPLE
    PS C:\> .\Network\Get-NetworkAdapters.ps1
    Name                         InterfaceDescription                     Status       MacAddress        LinkSpeed
    ----                         --------------------                     ------       ----------        ---------
    Ethernet                     Realtek PCIe GbE Family Controller       Up           00-00-00-00-00-00 1 Gbps 

    ...(more network adapters)  
    
    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 30-10-2024
    Version: 1.0
#>

# Get a list of all network adapters on the local computer
Get-NetAdapter | Select-Object Name, InterfaceDescription, Status, MacAddress, LinkSpeed | Format-Table -AutoSize

# Prompt the user to press Enter to exit
Read-Host -Prompt "Press Enter to exit"