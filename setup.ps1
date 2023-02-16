if(Get-Module -Name Dotfiles -ListAvailable)
{
    Import-Module Dotfiles
} else {
    $FirstModulePath = $env:PSModulePath -split ';' | Select-Object -First 1
    Write-Output "Installing 'Dotfiles' module to $FirstModulePath".
    New-Item -ItemType Junction -Path "$FirstModulePath\Dotfiles" -Target $PSScriptRoot\Dotfiles\ | Out-Null
    Import-Module Dotfiles
}

Disable-DotnetTelemetry
Install-Scoop
Install-ScoopApps $PSScriptRoot/scoop.json
sudo Install-ScoopApps $PSScriptRoot/scoop.global.json
Set-GitConfiguration
Set-WindowsTerminalConfiguration
Set-PowerShellProfile
Set-VisualStudioCodeConfiguration
Set-VimConfiguration

# Fallback winget installations
sudo winget import $PSScriptRoot/winget.json --accept-package-agreements --accept-source-agreements

Write-Output "Opening firefox for manual installers"
firefox "https://www.sync.com/download/win/sync-installer.exe"
firefox "https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/"

# Invoke-Expression "$PSScriptRoot\\Win10-Initial-Setup-Script\\Win10.ps1 -preset $PSScriptRoot\\config\\Win10.preset -include $PSScriptRoot\\Win10-Initial-Setup-Script\\Win10.psm1"
