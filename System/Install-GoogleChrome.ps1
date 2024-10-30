<#
.SYNOPSIS
    This script installs the latest version of Google Chrome.

.DESCRIPTION
    This script checks if Google Chrome is already installed, and if not, downloads and installs the latest version of Google Chrome.

.EXAMPLE
    PS C:\> .\System\Install-GoogleChrome.ps1

.NOTES
    Author: Braydon Pettit
    Date: 29-10-2024
    Version: 1.1
#>

# Function to check if Google Chrome is installed
function Test-ChromeInstalled {
    $chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
    return Test-Path $chromePath
}

# Define the URL for the Google Chrome installer
$installerUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"

# Define the path to save the installer
$installerPath = "$env:TEMP\ChromeInstaller.exe"

if (Test-ChromeInstalled) {
    Write-Output "Google Chrome is already installed. Cancelling installation."
} else {
    try {
        # Download the installer
        Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath -ErrorAction Stop

        # Run the installer
        Start-Process -FilePath $installerPath -ArgumentList "/silent /install" -Wait -ErrorAction Stop

        # Remove the installer after installation
        Remove-Item -Path $installerPath -Force -ErrorAction Stop

        # Output success message
        Write-Output "Google Chrome has been installed successfully."
    } catch {
        # Output error message
        Write-Error "An error occurred: $_"
    }
}