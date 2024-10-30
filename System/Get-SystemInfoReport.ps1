<#
.SYNOPSIS
    Generates a system information report and saves it to an HTML file.

.DESCRIPTION
    This script retrieves various system information, such as operating system details, memory information, graphics information, CPU information, disk information, and network adapter information. It then generates an HTML report with the collected information and saves it to a file in the "Reports" directory in the same directory as the script. The report includes the current date and time in Australian format. After generating the report, the script will automatically open the HTML file in the user's default web browser.
.EXAMPLE
    PS C:\> .\System\Get-SystemInfoReport.ps1
    Created: F:\PowerShell\System\Reports\systeminfo_28-10-2024 190210.html
    Opening the report in your default web browser...

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 15-10-2024
    Version: 1.0
#>

# Get OS information
$os = Get-CimInstance -ClassName Win32_OperatingSystem

# Get memory information
$memory = Get-CimInstance -ClassName Win32_PhysicalMemory

# Get graphics information
$graphics = Get-CimInstance -ClassName Win32_VideoController

# Get CPU information
$cpu = Get-CimInstance -ClassName Win32_Processor

# Get disk information
$disks = Get-CimInstance -ClassName Win32_DiskDrive

# Get network adapter information
$networkAdapters = Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }

# Get current date in Australian format
$date = Get-Date -Format "dd/MM/yyyy - hh:mm tt"

# Format LastBootUpTime in the same format as $date
$lastBootUpTime = Get-Date ($os.LastBootUpTime) -Format "dd/MM/yyyy - hh:mm tt"

# Initialize HTML content
$html = @"
<!DOCTYPE html>
<html>
<head>
    <title>System Information Report</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>System Information Report</h1>
    <p>Date: $date</p>
"@

# Add OS information
$html += "<h2>Operating System</h2>"
$html += "<table><tr><th>Property</th><th>Value</th></tr>"
$html += "<tr><td>Operating System</td><td>$($os.Caption)</td></tr>"
$html += "<tr><td>Version</td><td>$($os.Version)</td></tr>"
$html += "<tr><td>Architecture</td><td>$($os.OSArchitecture)</td></tr>"
$html += "<tr><td>Manufacturer</td><td>$($os.Manufacturer)</td></tr>"
$html += "<tr><td>Last Boot Up Time</td><td>$lastBootUpTime</td></tr>"
$html += "</table>"

# Add memory information
$html += "<h2>Memory</h2>"
$html += "<table><tr><th>Capacity (GB)</th><th>Speed (MHz)</th><th>Manufacturer</th><th>Part Number</th></tr>"
foreach ($mem in $memory) {
    $html += "<tr><td>$([math]::round($mem.Capacity / 1GB, 2))</td><td>$($mem.Speed)</td><td>$($mem.Manufacturer)</td><td>$($mem.PartNumber)</td></tr>"
}
$html += "</table>"

# Add graphics information
$html += "<h2>Graphics</h2>"
$html += "<table><tr><th>Name</th><th>Driver Version</th><th>Status</th><th>VRAM (MB)</th></tr>"
foreach ($gpu in $graphics) {
    $html += "<tr><td>$($gpu.Name)</td><td>$($gpu.DriverVersion)</td><td>$($gpu.Status)</td><td>$([math]::round($gpu.AdapterRAM / 1MB, 2))</td></tr>"
}
$html += "</table>"

# Add CPU information
$html += "<h2>CPU</h2>"
$html += "<table><tr><th>CPU Name</th><th>Manufacturer</th><th>Max Clock Speed (MHz)</th><th>Number of Cores</th><th>Number of Logical Processors</th></tr>"
foreach ($processor in $cpu) {
    $html += "<tr><td>$($processor.Name)</td><td>$($processor.Manufacturer)</td><td>$($processor.MaxClockSpeed)</td><td>$($processor.NumberOfCores)</td><td>$($processor.NumberOfLogicalProcessors)</td></tr>"
}
$html += "</table>"

# Add disk information
$html += "<h2>Disks</h2>"
$html += "<table><tr><th>Disk Model</th><th>Interface Type</th><th>Size (GB)</th><th>Partitions</th></tr>"
foreach ($disk in $disks) {
    $html += "<tr><td>$($disk.Model)</td><td>$($disk.InterfaceType)</td><td>$([math]::round($disk.Size / 1GB, 2))</td><td>$($disk.Partitions)</td></tr>"
}
$html += "</table>"

# Add network adapter information
$html += "<h2>Network Adapters</h2>"
$html += "<table><tr><th>Network Adapter</th><th>MAC Address</th><th>IP Address</th><th>Subnet Mask</th><th>Default Gateway</th></tr>"
foreach ($adapter in $networkAdapters) {
    $html += "<tr><td>$($adapter.Description)</td><td>$($adapter.MACAddress)</td><td>$($adapter.IPAddress -join ', ')</td><td>$($adapter.IPSubnet -join ', ')</td><td>$($adapter.DefaultIPGateway -join ', ')</td></tr>"
}
$html += "</table>"

# Close HTML content
$html += @"
</body>
</html>
"@

# Define the output path to the Log\HTML directory in the root directory
$rootDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$reportsDir = Join-Path -Path $rootDir -ChildPath "Log\HTML"

# Get current timestamp for unique filename
$timestamp = Get-Date -Format "dd-MM-yyyy HHmmss"
$outputPath = Join-Path -Path $reportsDir -ChildPath "systeminfo_$timestamp.html"

# Ensure the Log\HTML directory exists
if (-not (Test-Path -Path $reportsDir)) {
    New-Item -Path $reportsDir -ItemType Directory | Out-Null
}

# Save the HTML content to the file
$html | Out-File -FilePath $outputPath -Encoding UTF8

# Inform the user
Write-Host "Created: $outputPath"
Write-Host "`nOpening the report in your default web browser..."

# Open the HTML report in the default browser directly
Start-Process $outputPath

# Prompt user to press any key to exit
Read-Host -Prompt "`nPress Enter to exit"