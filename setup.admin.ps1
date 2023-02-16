#Requires -Version 7 -RunAsAdministrator

if(Get-Module -Name Dotfiles -ListAvailable)
{
    Import-Module Dotfiles
} else {
    $FirstModulePath = $env:PSModulePath -split ';' | Select-Object -First 1
    Write-Output "Installing 'Dotfiles' module to $FirstModulePath".
    New-Item -ItemType Junction -Path "$FirstModulePath\Dotfiles" -Target $PSScriptRoot\Dotfiles\ | Out-Null
    Import-Module Dotfiles
}

# Global scoop apps requires sudo
sudo scoop import $PSScriptRoot/scoop.global.json

# Fallback winget installations
sudo winget import $PSScriptRoot/winget.json --accept-package-agreements --accept-source-agreements