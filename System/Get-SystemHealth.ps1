<#
.SYNOPSIS
    This script checks the CPU, memory, and disk usage of the local machine and displays the results in the console.

.DESCRIPTION
    This script retrieves the CPU usage, memory usage, and disk usage of the local machine using WMI queries. It calculates the average CPU usage, memory usage as a percentage, and disk usage for each drive on the system. The script then displays the results in the console.

.EXAMPLE
    PS C:\> .\System\Get-SystemHealth.ps1
    CPU Usage: 7%

    Memory Usage: 69.99%

    Disk Usage:
    C:: 65.27%
    D:: 69.44%
    E:: 43.63%
    Z:: 41.13%

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 29-10-2024
    Version: 1.0
#>

# Function to check CPU usage
function Get-CPUUsage {
    $cpu = Get-WmiObject win32_processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
    return $cpu
}

# Function to check Memory usage
function Get-MemoryUsage {
    $memory = Get-WmiObject win32_operatingsystem
    $totalMemory = $memory.TotalVisibleMemorySize
    $freeMemory = $memory.FreePhysicalMemory
    $usedMemory = $totalMemory - $freeMemory
    $memoryUsage = [math]::round(($usedMemory / $totalMemory) * 100, 2)
    return $memoryUsage
}

# Function to check Disk usage
function Get-DiskUsage {
    $disk = Get-WmiObject win32_logicaldisk -Filter "DriveType=3"
    $diskUsage = @()
    foreach ($d in $disk) {
        $usedSpace = $d.Size - $d.FreeSpace
        $usagePercent = [math]::round(($usedSpace / $d.Size) * 100, 2)
        $diskUsage += [pscustomobject]@{
            Drive = $d.DeviceID
            Usage = $usagePercent
        }
    }
    return $diskUsage
}

# Main script
$cpuUsage = Get-CPUUsage
$memoryUsage = Get-MemoryUsage
$diskUsage = Get-DiskUsage

# Display results
Write-Host "CPU Usage: $cpuUsage%"
Write-Host "`nMemory Usage: $memoryUsage%"
Write-Host "`nDisk Usage:"
$diskUsage | ForEach-Object { Write-Host "$($_.Drive) $($_.Usage)%" }
Write-Host " "

# Prompt user to press Enter to exit
Read-Host -Prompt "Press Enter to exit"