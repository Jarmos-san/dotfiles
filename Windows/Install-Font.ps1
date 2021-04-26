<#
This script is for downloading the fonts & installing them.

To conform with with proper coding standards & conventions, following resources might prove useful.
https://techdocs.ed-fi.org/display/ETKB/PowerShell+Coding+Standards
https://poshcode.gitbook.io/powershell-practice-and-style/style-guide/readability

? Additional resources
* Nerd Fonts Homepage: https://www.nerdfonts.com/font-downloads

* Installing the fonts: https://powers-hell.com/2020/06/09/installing-fonts-with-powershell-intune/

Specific to this script, it downloads the FiraCode Nerd Font available at: https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip.
For now it's URI is hardcoded but it might be advisable to dynamically download the latest version as & when required.

? The Idea Behind the Script:

* -> Downloads the zipped file the extracts the contents locally.
* -> Filter out files based on these conditions:
*        => Are .ttf files
*        => Is Windows Compatible, Mono
*        => Are Bold, Light, Medium & Regular
* -> Copy the fonts into "C:\Windows\Fonts"
* -> Make a Registry entry at "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
* -> Then delete the extracted files as well as the zipped file.
#>
