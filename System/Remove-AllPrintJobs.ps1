<#
.SYNOPSIS
    Removes all print jobs from all printers.

.DESCRIPTION
    This script uses the Get-Printer and Get-PrintJob cmdlets to retrieve a list of all printers and all print jobs for each printer. It then removes each print job from each printer.

.EXAMPLE
    PS C:\> ..\System\Remove-AllPrintJobs.ps1

    All print jobs have been removed from all printers.
    
    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 30-10-2024
    Version: 1.0
#>

# Get a list of all printers
$printers = Get-Printer

foreach ($printer in $printers) {
    # Get the printer name
    $printerName = $printer.Name
    
    # Get all print jobs for the current printer
    $printJobs = Get-PrintJob -PrinterName $printerName
    
    foreach ($job in $printJobs) {
        # Remove each print job
        Remove-PrintJob -PrinterName $printerName -ID $job.ID
    }
}

# Output a message indicating that all print jobs have been removed
Write-Output "All print jobs have been removed from all printers."

# Prompt the user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"