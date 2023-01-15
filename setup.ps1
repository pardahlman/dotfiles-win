
function CommandNotAvailable($commandName) {
    if (Get-Command $commandName -ErrorAction SilentlyContinue) {
        return $false
    }

    return $true
}

if (CommandNotAvailable("scoop")) {
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

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

Install-ScoopApps ./scoop.json

$DotNetOptOut = [System.Environment]::GetEnvironmentVariable("DOTNET_CLI_TELEMETRY_OPTOUT", "User")
if ($DotNetOptOut -eq $null) {
    Write-Output "Opting out from .NET Telemetry"
    [System.Environment]::SetEnvironmentVariable("DOTNET_CLI_TELEMETRY_OPTOUT", 1, "User")
}

New-Item -ItemType HardLink -Force -Path $PROFILE -Target $PSScriptRoot\config\pwsh\Microsoft.PowerShell_profile.ps1 | Out-Null
New-Item -Type HardLink -Force -Path $env:APPDATA\Code\User -Name settings.json -Target $PSScriptRoot\config\vscode\settings.json | Out-Null

Set-GitConfiguration
Set-WindowsTerminalConfiguration

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
