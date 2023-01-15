if(-not (Get-Module -Name Dotfiles))
{
    if(Get-Module -Name Dotfiles -ListAvailable)
    {
        Import-Module Dotfiles
    } else {
        $FirstModulePath = $env:PSModulePath -split ';' | Select-Object -First 1
        if(-not (Test-Path "$FirstModulePath\Dotfiles"))
        {
            Write-Output "Installing 'Dotfiles' module to $FirstModulePath".
            New-Item -ItemType Junction -Path "$FirstModulePath\Dotfiles" -Target $PSScriptRoot\Dotfiles\ | Out-Null
            Import-Module Dotfiles
        }
    }
}

Disable-DotnetTelemetry
Install-Scoop
Install-ScoopApps ./scoop.json
Set-GitConfiguration
Set-WindowsTerminalConfiguration
Set-PowerShellProfile
Set-VisualStudioCodeConfiguration

if (Test-Path $HOME/.vim_runtime) {
    Write-Output "Updating VIM configuration"
    Push-Location $HOME/.vim_runtime
    git pull --rebase
    Pop-Location
}
else {
    Write-Output "Installing VIM configuration"
    git clone --depth=1 https://github.com/amix/vimrc.git $HOME/.vim_runtime
    New-Item -ItemType HardLink -Force -Path $HOME -Name .vimrc -Value $HOME\.vim_runtime\vimrcs\basic.vim | Out-Null
}

Write-Output "Opening firefox for manual installers"
firefox "https://www.sync.com/download/win/sync-installer.exe"
firefox "https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/"

# Invoke-Expression "$PSScriptRoot\\Win10-Initial-Setup-Script\\Win10.ps1 -preset $PSScriptRoot\\config\\Win10.preset -include $PSScriptRoot\\Win10-Initial-Setup-Script\\Win10.psm1"
