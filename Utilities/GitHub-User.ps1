<#
.SYNOPSIS
    Get GitHub user information.

.DESCRIPTION
    This script retrieves information about a GitHub user using the GitHub API. The user's username, bio, and number of public repositories are displayed.

.EXAMPLE
    PS C:\> .\Utilities\GitHub-User.ps1
    Enter GitHub username: bray2sick

    Username: bray2sick
    Bio: Passionate about web development, system administration, cybersecurity and networking.
    Public Repos: 4

    Press Enter to exit:

.LINK
    https://github.com/bray2sick/PowerShell
    
.NOTES
    Author: Braydon Pettit
    Date: 30-10-2024
    Version: 1.0
#>


param (
    [string]$GitHubUsername
)

# Function to get GitHub user information
function Get-GitHubUserInfo {
    param (
        [string]$Username
    )

    # Make a request to the GitHub API to get user information
    $url = "https://api.github.com/users/$Username"
    $response = Invoke-RestMethod -Uri $url -Method Get

    return $response
}

# Main script
if (-not $GitHubUsername) {
    $GitHubUsername = Read-Host "Enter GitHub username"
}

$userInfo = Get-GitHubUserInfo -Username $GitHubUsername

# Display user information
Write-Output "Username: $($userInfo.login)"
Write-Output "Bio: $($userInfo.bio)"
Write-Output "Public Repos: $($userInfo.public_repos)"

# Prompt the user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"
