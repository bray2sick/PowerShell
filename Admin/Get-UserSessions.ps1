<#
.SYNOPSIS
    This script retrieves information about user sessions on the system and displays it in a table. The information includes the user's name, session ID, state, and idle time.

.DESCRIPTION
    This script uses the 'quser' command to retrieve information about user sessions on the system. The output is displayed in a table format, showing the user's name, session ID, state, and idle time.
    
.EXAMPLE
    PS C:\> .\Admin\Get-UserSessions.ps1
     USERNAME              SESSIONNAME        ID  STATE   IDLE TIME  LOGON TIME
     >braydon              console            1  Active        none  25/10/2024 6:28 PM

     Press Enter to exit:
     
.LINK
    https://github.com/bray2sick/PowerShell

.NOTES
    Author: Braydon Pettit
    Date: 15-10-2024
    Version: 1.0
#>

# Run the 'quser' command and capture the output
$userSessions = quser

# Display the output
$userSessions

# Prompt user to press Enter to exit
Read-Host -Prompt "`nPress Enter to exit"