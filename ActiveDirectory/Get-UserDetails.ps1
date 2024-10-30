# Prompt for user input
$firstName = Read-Host "Enter the user's first name"
$lastName = Read-Host "Enter the user's last name"

# Search Active Directory for the user
$user = Get-ADUser -Filter {GivenName -eq $firstName -and Surname -eq $lastName} -Properties *

# Check if user is found
if ($user) {
    # Display user details
    Write-Output "`nUser Details:"
    Write-Output "Name: $($user.Name)"
    Write-Output "UPN: $($user.UserPrincipalName)"
    Write-Output "SamAccountName: $($user.SamAccountName)"  
    Write-Output "Email: $($user.EmailAddress)"
    Write-Output "Title: $($user.Title)"
    Write-Output "Department: $($user.Department)"
    Write-Output "Last Logon Time: $($user.LastLogonDate)"

} else {
    Write-Host "`nUser not found." -ForegroundColor Red
}

# Prompt the user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"