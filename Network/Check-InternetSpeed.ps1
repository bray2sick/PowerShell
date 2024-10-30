<#
.SYNOPSIS
    Checks the internet speed using speedtest-cli.

.DESCRIPTION
    This script checks the internet speed using the speedtest-cli tool. If the tool is not installed, it installs it using pip. The script then runs the speed test and displays the results.
.EXAMPLE
    PS C:\> .\Network\Check-InternetSpeed.ps1
    
    Running internet speed test...

    Internet Speed Test Results:
    Ping: 10.123 ms
    Download: 50.12 Mbit/s
    Upload: 20.34 Mbit/s

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 24-10-2024
    Version: 1.0
#>

# Ensure pip is installed
if (-not (Get-Command pip -ErrorAction SilentlyContinue)) {
    Write-Output "pip is not installed. Installing pip..."
    Invoke-WebRequest -Uri https://bootstrap.pypa.io/get-pip.py -OutFile get-pip.py
    python get-pip.py
    Remove-Item get-pip.py
}

# Ensure speedtest-cli is installed
if (-not (Get-Command speedtest -ErrorAction SilentlyContinue)) {
    Write-Output "speedtest-cli is not installed. Installing..."
    pip install speedtest-cli
}

# Run the speed test
Write-Output "`nRunning internet speed test..."
$speedTestResult = speedtest --simple

# Display the results
Write-Output "`nInternet Speed Test Results:"
Write-Output $speedTestResult

# Prompt user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"