function ScoopInstallOrUpdate($appName) {
    Write-Output "Installing $appName..."
    Invoke-Expression "powershell -Command scoop install $appName" | Out-Null
    Invoke-Expression "powershell -Command scoop update $appName" | Out-Null
}

if(Get-Command $commandName -ErrorAction SilentlyContinue)
{
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

$BucketNames = scoop bucket list | Select-Object -ExpandProperty Name
foreach ($BucketName in @("main","extras","nerd-fonts")) {
  if(-not $BucketNames.Contains($BucketName))
    {
        Write-Output "Adding bucket $bucketName"
        scoop bucket add extras 6> $null
    }
 }


ScoopInstallOrUpdate("git")
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
ScoopInstallOrUpdate("beyondcompare")
ScoopInstallOrUpdate("docker")
ScoopInstallOrUpdate("vlc")
ScoopInstallOrUpdate("steam")
ScoopInstallOrUpdate("signal")
ScoopInstallOrUpdate("slack")
ScoopInstallOrUpdate("pwsh")

$DotNetOptOut = [System.Environment]::GetEnvironmentVariable("DOTNET_CLI_TELEMETRY_OPTOUT", "User");
if($DotNetOptOut -eq $null){
    Write-Output "Opting out from .NET Telemetry"
    [System.Environment]::SetEnvironmentVariable("DOTNET_CLI_TELEMETRY_OPTOUT", 1, "User")
}

if(Test-Path $HOME\.gitconfig.local){
    Write-Host "Local git configuration found"
} else {
    Copy-Item -Path $PSScriptRoot\config\git\gitconfig.local -Destination $HOME\.gitconfig.local | Out-null
}

New-Item -ItemType HardLink -Force -Path $HOME -Name .gitignore -Value $PSScriptRoot\config\git\gitignore | Out-null
New-Item -ItemType HardLink -Force -Path $HOME -Name .gitattributes -Value $PSScriptRoot\config\git\gitattributes | Out-null
New-Item -ItemType HardLink -Force -Path $HOME -Name .gitconfig -Value $PSScriptRoot\config\git\gitconfig | Out-null
New-Item -ItemType HardLink -Force -Path $env:APPDATA\Hyper -Name .hyper.js -Target $PSScriptRoot\config\hyperjs\hyper.js | Out-Null
New-Item -ItemType HardLink -Force -Path $PROFILE -Target $PSScriptRoot\config\pwsh\Microsoft.PowerShell_profile.ps1 | Out-Null
New-Item -Type HardLink -Force -Path $env:APPDATA\Code\User -Name settings.json -Target $PSScriptRoot\config\vscode\settings.json | Out-Null

if(Test-Path $HOME/.vim_runtime){
    Write-Output "Updating VIM configuration"
    Push-Location $HOME/.vim_runtime
    git pull --rebase
    Pop-Location
} else {
    Write-Output "Installing VIM configuration"
    git clone --depth=1 https://github.com/amix/vimrc.git $HOME/.vim_runtime
    New-Item -ItemType HardLink -Force -Path $HOME -Name .vimrc -Value $HOME\.vim_runtime\vimrcs\basic.vim | Out-null
}

Write-Output "Opening firefox for manual installers"
firefox "https://www.sync.com/download/win/sync-installer.exe"
firefox "https://download.scdn.co/SpotifySetup.exe"
firefox "https://addons.mozilla.org/en-US/firefox/addon/lastpass-password-manager/"
firefox "https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/"
firefox "https://hyper.is/#installation"

Invoke-Expression "$PSScriptRoot\\Win10-Initial-Setup-Script\\Win10.ps1 -preset $PSScriptRoot\\config\\Win10.preset -include $PSScriptRoot\\Win10-Initial-Setup-Script\\Win10.psm1"
