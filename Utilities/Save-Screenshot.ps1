<#
.SYNOPSIS
    Takes a hidden screenshot of the user's primary screen and saves it to a file.

.DESCRIPTION
    This script takes a screenshot of the primary screen and saves it to a file in the "Logs/Screenshots" folder in the same directory as the script. The screenshot is saved in PNG format with a filename that includes the current date and time.

.EXAMPLE
    PS C:\> .\Utilities\Save-Screenshot.ps1

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 15-10-2024
    Version: 1.0
#>

# Define the path to the "Logs/Screenshots" folder
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$rootDir = Split-Path -Parent $scriptDir
$screenshotDir = Join-Path -Path $rootDir -ChildPath "Log/Screenshots"

# Create the "Logs/Screenshots" folder if it doesn't exist
if (-not (Test-Path -Path $screenshotDir)) {
    New-Item -ItemType Directory -Path $screenshotDir | Out-Null
}

# Define the path for the screenshot file
$screenshotFile = Join-Path -Path $screenshotDir -ChildPath ("Screenshot_{0:dd-MM-yyyy_HH-mm-ss}.png" -f (Get-Date))

# Take the screenshot and save it to the file
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$bitmap = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size)
$bitmap.Save($screenshotFile, [System.Drawing.Imaging.ImageFormat]::Png)

# Clean up
$graphics.Dispose()
$bitmap.Dispose()