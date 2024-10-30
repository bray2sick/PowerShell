<#
.SYNOPSIS
    List all print jobs on the system.

.DESCRIPTION
    This script retrieves a list of all printers on the system and displays information about each printer, including the print jobs in the queue.

.EXAMPLE
    PS C:\> .\System\List-PrintJobs.ps1

    Printer: OneNote (Desktop)
    No print jobs found.

    Printer: Microsoft Print to PDF
    No print jobs found.

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

# Loop through each printer and get the print jobs
foreach ($printer in $printers) {
    Write-Host "Printer: $($printer.Name)"
    $printJobs = Get-PrintJob -PrinterName $printer.Name
    if ($printJobs) {
        $printJobs | Format-Table -Property JobId, DocumentName, UserName, TotalPages, Status
    } else {
        Write-Host "No print jobs found."
    }
    Write-Host ""
}

# Prompt the user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"
