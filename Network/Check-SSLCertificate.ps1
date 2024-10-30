<#
.SYNOPSIS
    This script retrieves information about the SSL certificate of a website and displays it in a human-readable format. 

.DESCRIPTION
    This script takes a website URL as input and retrieves the SSL certificate information for that website. It uses the .NET HttpWebRequest class to make a request to the website and retrieve the SSL certificate. The script then extracts information such as the issuer, subject, effective date, expiry date, and thumbprint of the certificate and displays it in the console.

.EXAMPLE
    PS C:\> .\Network\Check-SSLCertificate.ps1
    Please enter the website (e.g., google.com or example.com): google.com
    
    Website: google.com
    Issuer: CN=WR2, O=Google Trust Services, C=US
    Subject: CN=*.google.com
    Effective Date: 10/07/2024 19:23:38
    Expiry Date: 12/30/2024 19:23:37
    Thumbprint: 8AFD2ECFC637BB8675C1A896342AA21913ED3B80

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 15-10-2024
    Version: 1.0
#>

# Prompt user for website URL
param (
    [string]$website
)

# If website parameter is not provided, prompt user to enter website URL
if (-not $website) {
    $website = Read-Host "Please enter the website (e.g., google.com or example.com)"
}

# If website parameter is provided, use it directly
try {
    $request = [Net.HttpWebRequest]::Create("https://$website")
    $request.AllowAutoRedirect = $false
    $request.Timeout = 10000
    $request.GetResponse() | Out-Null
    $certificate = $request.ServicePoint.Certificate
    $cert2 = New-Object Security.Cryptography.X509Certificates.X509Certificate2 $certificate
    # Display SSL certificate information
    Write-Host "`nWebsite: $website"
    Write-Host "Issuer: $($cert2.Issuer)"
    Write-Host "Subject: $($cert2.Subject)"
    Write-Host "Effective Date: $($cert2.NotBefore)"
    Write-Host "Expiry Date: $($cert2.NotAfter)"
    Write-Host "Thumbprint: $($cert2.Thumbprint)"
}
catch {
    # Display error message if SSL certificate retrieval fails
    Write-Host "Failed to retrieve SSL certificate for $website"
    Write-Host $_.Exception.Message
}

# Prompt user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"