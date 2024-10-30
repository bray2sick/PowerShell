<#
.SYNOPSIS
    Opens the Recycle Bin in Windows.

.DESCRIPTION
    This script opens the Recycle Bin in Windows. The Recycle Bin is a temporary storage location for files that have been deleted from the computer. It allows users to restore deleted files or permanently delete them.

.EXAMPLE
    PS C:\> .\System\Open-RecycleBin.ps1

.LINK

.NOTES
    Author: Braydon Pettit
    Date: 30-10-2024
    Version: 1.0
#>


# Open Recycle Bin
Start-Process "shell:RecycleBinFolder"