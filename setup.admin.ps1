#Requires -Version 7 -RunAsAdministrator

# Global scoop apps requires sudo
sudo Install-ScoopApps $PSScriptRoot/scoop.global.json

# Fallback winget installations
sudo winget import $PSScriptRoot/winget.json --accept-package-agreements --accept-source-agreements