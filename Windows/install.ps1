# Script to install necessary software

# TODO: Installation script for Starship Cross-Shell Prompt
#   More info are available at:
#       https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Archive/Expand-Archive?view=powershell-7.2
#       https://stackoverflow.com/questions/41895772/powershell-script-to-download-a-zip-file-and-unzip-it
# TODO: Refactor the code. Write a function to parse a JSON file with all the required information instead.

Write-Host "Installing Vim"
winget install -e --id vim.vim
Write-Host "Vim installed!"

Write-Host "Installing PowerShell Core"
winget install -e --id Microsoft.PowerShell
Write-Host "PowerShell Core installed!"

Write-Host "Installing Steam"
winget install -e --id Valve.Steam
Write-Host "Steam installed!"

Write-Host "Installing Visual Studio Code"
winget install -e --id Microsoft.VisualStudio.Code
Write-Host "Visual Studio Code installed!"

Write-Host "Installing Alacritty"
winget install -e --id Alacritty.Alacritty
Write-Host "Alacritty installed!"

Write-Host "Installing Transmission Bittorrent Client"
winget install -e --id Transmission.Transmission
Write-Host "Transmission Bittorent Client installed!"

Write-Host "Installing VLC Media Player"
winget install -e --id VideoLAN.VLC
Write-Host "VLC Media Player installed"

Write-Host "Installing Python"
winget install -e --id Python.Python
Write-Host "Python installed"

Write-Host "Installing ShareX"
winget install -e --id ShareX.ShareX
Write-Host "ShareX installed"

Write-Host "Installing Google Backup & Sync"
winget install -e --id Google.BackupAndSync
Write-Host " Google Backup & Sync installed"
