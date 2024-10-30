<#
.SYNOPSIS
    Displays the ARP table of the local machine.

.DESCRIPTION
    This script retrieves and displays the ARP table entries of the local machine using the Get-NetNeighbor cmdlet.

.EXAMPLE
    PS C:\> .\Network\Display-ARPTable.ps1

    ifIndex IPAddress        LinkLayerAddress  State
    ------- ---------        ----------------  -----
    11      192.168.0.1      00-00-00-00-00-00 Reachable
    11      192.168.0.2      00-00-00-00-00-00 Stale

    ... (more entries)
    
    Press Enter to exit: 

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 29-10-2024
    Version: 1.0
#>

# Retrieve ARP table entries
$arpTable = Get-NetNeighbor

# Display ARP table entries
$arpTable | Format-Table -Property ifIndex, IPAddress, LinkLayerAddress, State -AutoSize

# Wait for user input before exiting
Write-Host "Press Enter to exit:"
[void][System.Console]::ReadLine()