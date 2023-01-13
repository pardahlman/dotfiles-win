function ScoopInstallOrUpdate($appName) {
    Write-Output "Installing $appName..."
    Invoke-Expression "powershell -Command scoop install $appName" | Out-Null
    Invoke-Expression "powershell -Command scoop update $appName" | Out-Null
}

function CommandNotAvailable($commandName) {
    if (Get-Command $commandName -ErrorAction SilentlyContinue) {
        return $false
    }

    return $true
}

function ScoopAddScoopBucket($bucketName) {
    Write-Output "Adding bucket $bucketName"
    Invoke-Expression "powershell -Command scoop bucket add $bucketName" | Out-Null
}

if (CommandNotAvailable("scoop")) {
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

ScoopInstallOrUpdate("git")
ScoopAddScoopBucket("extras")
ScoopInstallOrUpdate("sudo")
ScoopInstallOrUpdate("z")
ScoopInstallOrUpdate("dotnet-sdk")
ScoopInstallOrUpdate("posh-git")
ScoopInstallOrUpdate("nvm")
ScoopInstallOrUpdate("busybox")
ScoopInstallOrUpdate("vim")
ScoopInstallOrUpdate("vscode")
ScoopInstallOrUpdate("jetbrains-toolbox")
ScoopInstallOrUpdate("firefox")
ScoopInstallOrUpdate("everything")
ScoopInstallOrUpdate("docker")
ScoopInstallOrUpdate("spotify")
ScoopInstallOrUpdate("signal")
ScoopInstallOrUpdate("slack")
ScoopInstallOrUpdate("windows-terminal")
ScoopInstallOrUpdate("bitwarden")
ScoopInstallOrUpdate("keepass")

$DotNetOptOut = [System.Environment]::GetEnvironmentVariable("DOTNET_CLI_TELEMETRY_OPTOUT", "User")
if ($DotNetOptOut -eq $null) {
    Write-Output "Opting out from .NET Telemetry"
    [System.Environment]::SetEnvironmentVariable("DOTNET_CLI_TELEMETRY_OPTOUT", 1, "User")
}

if (Test-Path $HOME\.gitconfig.local) {
    Write-Out "Local git configuration found"
}
else {
    Copy-Item -Path $PSScriptRoot\config\git\gitconfig.local -Destination $HOME\.gitconfig.local | Out-Null
}

New-Item -ItemType HardLink -Force -Path $HOME -Name .gitignore -Value $PSScriptRoot\config\git\gitignore | Out-Null
New-Item -ItemType HardLink -Force -Path $HOME -Name .gitattributes -Value $PSScriptRoot\config\git\gitattributes | Out-Null
New-Item -ItemType HardLink -Force -Path $HOME -Name .gitconfig -Value $PSScriptRoot\config\git\gitconfig | Out-Null
New-Item -ItemType HardLink -Force -Path $HOME -Name .gitconfig.delta -Value $PSScriptRoot\config\git\gitconfig.delta | Out-Null
New-Item -ItemType HardLink -Force -Path $PROFILE -Target $PSScriptRoot\config\pwsh\Microsoft.PowerShell_profile.ps1 | Out-Null
New-Item -Type HardLink -Force -Path $env:APPDATA\Code\User -Name settings.json -Target $PSScriptRoot\config\vscode\settings.json | Out-Null
New-Item -Type HardLink -Force -Path "$env:LOCALAPPDATA\Microsoft\Windows Terminal" -Name settings.json -Target $PSScriptRoot\config\windows-terminal\settings.json | Out-Null
# Best effort for Windows Terminal: copy the configuration file. Default themes, profiles etc
# will be added when application is started, but the settings in this file are not overwritten.
Copy-Item -Path $PSScriptRoot\config\windows-terminal\settings.json -Destination "$env:LOCALAPPDATA\Microsoft\Windows Terminal\settings.json"

$FirstModulePath = $env:PSModulePath -split ';' | Select-Object -First 1
if(-not (Test-Path "$FirstModulePath\Dotfiles"))
{
    New-Item -ItemType Junction -Path "$FirstModulePath\Dotfiles" -Target $PSScriptRoot\Dotfiles\ | Out-Null
}

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
