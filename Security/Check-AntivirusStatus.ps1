<#
.SYNOPSIS
    This script checks the status of the antivirus products installed on the system.

.DESCRIPTION
    This script uses WMI to query the SecurityCenter2 namespace to retrieve information about the antivirus products installed on the system. It displays the name of the antivirus product, its state, and the timestamp of the information.

.EXAMPLE
    PS C:\> .\Security\Check-AntivirusStatus.ps1

    Antivirus Name: Windows Defender
    Product State: 397568
    Timestamp: Sun, 11 Oct 2093 07:30:45 GMT
    ----------------------------------------
    
    Press Enter to exit

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 29-10-2024
    Version: 1.0
#>

# Get the antivirus product information from WMI
$antivirusProduct = Get-WmiObject -Namespace "Root\SecurityCenter2" -Class "AntivirusProduct"

# Check if any antivirus product is found
if ($antivirusProduct) {
    foreach ($product in $antivirusProduct) {
        Write-Output "Antivirus Name: $($product.displayName)"
        Write-Output "Product State: $($product.productState)"
        Write-Output "Timestamp: $($product.timestamp)"
    }
} else {
    Write-Output "No antivirus product found on this machine."
}

# Prompt the user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"