<#
.SYNOPSIS
    Review GPOs in the domain.

.DESCRIPTION
    This script generates a report of all Group Policy Objects (GPOs) in the domain and saves it to an HTML file. The report includes information such as the GPO name, GUID, status, and links to sites, domains, and organizational units (OUs). After generating the report, the script will automatically open the HTML file in the user's default web browser.

.EXAMPLE
    PS C:\> .\Security\Review-GPO.ps1
    Generating GPO report...
    Opening the report in your default web browser...

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 30-10-2024
    Version: 1.0
#>

Write-Host "Generating GPO report..."

# Create the Log directory if it does not exist
gpresult /h "Log/HTML/gpo_report.html"

Write-Host "Opening the report in your default web browser..."

# Open the HTML report in the default web browser
Start-Process ".\Log\HTML\gpo_report.html"