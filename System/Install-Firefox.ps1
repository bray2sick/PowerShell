<#
.SYNOPSIS
    This script installs the latest version of Mozilla Firefox.

.DESCRIPTION
    This script checks if Firefox is already installed, and if not, downloads and installs the latest version of Firefox.

.EXAMPLE
    PS C:\> .\System\Install-Firefox.ps1

.NOTES
    Author: Braydon Pettit
    Date: 29-10-2024
    Version: 1.1
#>

# Function to check if Firefox is installed
function Test-FirefoxInstalled {
    $firefoxPath = "C:\Program Files\Mozilla Firefox\firefox.exe"
    return Test-Path $firefoxPath
}

# Define the URL for the Firefox installer
$installerUrl = "https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US"

# Define the path to save the installer
$installerPath = "$env:TEMP\FirefoxInstaller.exe"

if (Test-FirefoxInstalled) {
    Write-Output "Firefox is already installed. Cancelling installation."
} else {
    try {
        # Download the installer
        Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath -ErrorAction Stop

        # Run the installer
        Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait -ErrorAction Stop

        # Remove the installer after installation
        Remove-Item -Path $installerPath -Force -ErrorAction Stop

        # Output success message
        Write-Output "Firefox has been installed successfully."
    } catch {
        # Output error message
        Write-Error "An error occurred: $_"
    }
}