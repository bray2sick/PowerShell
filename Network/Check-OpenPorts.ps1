<#
.SYNOPSIS
    Retrieve a list of open ports on the local machine.

.DESCRIPTION
    This script retrieves a list of open ports on the local machine using the Get-NetTCPConnection cmdlet. It filters the results to only show ports in the 'Listen' state and displays the local address and port number for each open port.

.EXAMPLE
    PS C:\> .\Network\Check-OpenPorts.ps1
    LocalAddress  LocalPort
    ------------  ---------
    ::                00000
    ::                00000
    ::                00000
    ::                00000
    ::                00000

    ... (more open ports)

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 29-10-2024
    Version: 1.0
#>

function Get-OpenPorts {
    try {
        # Retrieve open ports in 'Listen' state
        $connections = Get-NetTCPConnection | Where-Object { $_.State -eq 'Listen' }
        $connections | Select-Object LocalAddress, LocalPort | Out-Host
    } catch {
        Write-Error "Failed to retrieve open ports: $_"
    }
}

# Execute the function
Get-OpenPorts

# Prompt user to press Enter to exit
Read-Host -Prompt "Press Enter to exit"
