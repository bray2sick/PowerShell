<#
.SYNOPSIS
    Generates a system information report and displays it in the console.

.DESCRIPTION
    This script retrieves various system information, such as operating system details, memory information, graphics information, CPU information, disk information, and network adapter information. It then displays the collected information in the console.

.EXAMPLE
    PS C:\> .\System\Get-SystemInfo.ps1
    Date: 28/10/2024 06:57 PM

    Operating System: Microsoft Windows 11 Pro
    Version: 10.0.22631
    Architecture: 64-bit
    Manufacturer: Microsoft Corporation
    Last Boot Up Time: 10/25/2024 18:28:26

    Capacity: 16 GB
    Speed: 3600 MHz
    Manufacturer: Unknown
    Part Number: CMK32GX4M2D3600C18

    Capacity: 16 GB
    Speed: 3600 MHz
    Manufacturer: Unknown
    Part Number: CMK32GX4M2D3600C18

    Name: NVIDIA GeForce RTX 3060
    Driver Version: 32.0.15.6603
    Status: OK
    VRAM: 4095 MB

    CPU Name: AMD Ryzen 7 5800X 8-Core Processor
    Manufacturer: AuthenticAMD
    Max Clock Speed: 3801 MHz
    Number of Cores: 8
    Number of Logical Processors: 16

    Disk Model:  USB  SanDisk 3.2Gen1 USB Device
    Interface Type: USB
    Size: 114.61 GB
    Partitions: 1

    Disk Model: WDC WD10JPCX-24UE4T0
    Interface Type: IDE
    Size: 931.51 GB
    Partitions: 5

    Disk Model: KINGSTON SNVS1000G
    Interface Type: SCSI
    Size: 931.51 GB
    Partitions: 3

    Disk Model:  USB  SanDisk 3.2Gen1 USB Device
    Interface Type: USB
    Size: 28.67 GB
    Partitions: 1

    Disk Model: Samsung SSD 860 QVO 1TB
    Interface Type: IDE
    Size: 931.51 GB
    Partitions: 1

    Disk Model: ST1000DM010-2EP102
    Interface Type: IDE
    Size: 931.51 GB
    Partitions: 1

    Network Adapter: Realtek PCIe GbE Family Controller
    MAC Address: 00-00-00-00-00-00
    IP Address: 192.168.0.100
    Subnet Mask: 255.255.255.0
    Default Gateway: 192.168.0.1

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 15-10-2024
    Version: 1.0
#>

# Get today's date
$date = Get-Date -Format "dd/MM/yyyy hh:mm tt"

# Display today's date
Write-Host "Date: $date"

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

# Display OS information
Write-Host "`nOperating System: $($os.Caption)"
Write-Host "Version: $($os.Version)"
Write-Host "Architecture: $($os.OSArchitecture)"
Write-Host "Manufacturer: $($os.Manufacturer)"
Write-Host "Last Boot Up Time: $($os.LastBootUpTime)"

# Display memory information
foreach ($mem in $memory) {
    Write-Host "`nCapacity: $([math]::round($mem.Capacity / 1GB, 2)) GB"
    Write-Host "Speed: $($mem.Speed) MHz"
    Write-Host "Manufacturer: $($mem.Manufacturer)"
    Write-Host "Part Number: $($mem.PartNumber)"
}

# Display graphics information
foreach ($gpu in $graphics) {
    Write-Host "`nName: $($gpu.Name)"
    Write-Host "Driver Version: $($gpu.DriverVersion)"
    Write-Host "Status: $($gpu.Status)"
    Write-Host "VRAM: $([math]::round($gpu.AdapterRAM / 1MB, 2)) MB"
}

# Display CPU information
foreach ($processor in $cpu) {
    Write-Host "`nCPU Name: $($processor.Name)"
    Write-Host "Manufacturer: $($processor.Manufacturer)"
    Write-Host "Max Clock Speed: $($processor.MaxClockSpeed) MHz"
    Write-Host "Number of Cores: $($processor.NumberOfCores)"
    Write-Host "Number of Logical Processors: $($processor.NumberOfLogicalProcessors)"
}

# Display disk information
foreach ($disk in $disks) {
    Write-Host "`nDisk Model: $($disk.Model)"
    Write-Host "Interface Type: $($disk.InterfaceType)"
    Write-Host "Size: $([math]::round($disk.Size / 1GB, 2)) GB"
    Write-Host "Partitions: $($disk.Partitions)"
}

# Display network adapter information
foreach ($adapter in $networkAdapters) {
    Write-Host "`nNetwork Adapter: $($adapter.Description)"
    Write-Host "MAC Address: $($adapter.MACAddress)"
    Write-Host "IP Address: $($adapter.IPAddress -join ', ')"
    Write-Host "Subnet Mask: $($adapter.IPSubnet -join ', ')"
    Write-Host "Default Gateway: $($adapter.DefaultIPGateway -join ', ')"
}

# Prompt user to press any key to exit
Read-Host -Prompt "`nPress Enter to exit"