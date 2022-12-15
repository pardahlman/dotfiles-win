#Requires -Version 5

function Invoke-ScoopImport {
    Param($JsonPath)
    scoop import $JsonPath 6> $null
}

function Invoke-ScoopUpdate {
    Param()
    scoop update 6> $null
}

function Install-Scoop {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingInvokeExpression", "")]
    Param()
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

if(-not (Get-Command scoop -ErrorAction SilentlyContinue))
{
    Write-Output "scoop is not installed, installing..."
    Install-Scoop
}

$ScoopJsonPath = "$PSScriptRoot\scoop.json"
If(-not (Test-Path $ScoopJsonPath))
{
    Write-Output "$ScoopJsonPath not found. Make sure the file exists in order to install apps using scoop"
}
else
{
    Write-Output "Installing the following apps:"
    Get-Content .\scoop.json | ConvertFrom-Json -AsHashtable | Select-Object -ExpandProperty apps | Select-Object -ExpandProperty Name | Write-Output
    Invoke-ScoopImport $ScoopJsonPath
    Invoke-ScoopUpdate
}

$DotnetOptOutVariable = "DOTNET_CLI_TELEMETRY_OPTOUT"
if($null -eq [System.Environment]::GetEnvironmentVariable($DotnetOptOutVariable, "User") ){
    Write-Output "Opting out from .NET Telemetry"
    [System.Environment]::SetEnvironmentVariable($DotnetOptOutVariable, 1, "User")
}

# if(Test-Path $HOME\.gitconfig.local){
#     Write-Output "Local git configuration found"
# } else {
#     Copy-Item -Path $PSScriptRoot\config\git\gitconfig.local -Destination $HOME\.gitconfig.local | Out-null
# }

# New-Item -ItemType HardLink -Force -Path $HOME -Name .gitignore -Value $PSScriptRoot\config\git\gitignore | Out-null
# New-Item -ItemType HardLink -Force -Path $HOME -Name .gitattributes -Value $PSScriptRoot\config\git\gitattributes | Out-null
# New-Item -ItemType HardLink -Force -Path $HOME -Name .gitconfig -Value $PSScriptRoot\config\git\gitconfig | Out-null
# New-Item -ItemType HardLink -Force -Path $env:APPDATA\Hyper -Name .hyper.js -Target $PSScriptRoot\config\hyperjs\hyper.js | Out-Null
# New-Item -ItemType HardLink -Force -Path $PROFILE -Target $PSScriptRoot\config\pwsh\Microsoft.PowerShell_profile.ps1 | Out-Null
# New-Item -Type HardLink -Force -Path $env:APPDATA\Code\User -Name settings.json -Target $PSScriptRoot\config\vscode\settings.json | Out-Null

# if(Test-Path $HOME/.vim_runtime){
#     Write-Output "Updating VIM configuration"
#     Push-Location $HOME/.vim_runtime
#     git pull --rebase
#     Pop-Location
# } else {
#     Write-Output "Installing VIM configuration"
#     git clone --depth=1 https://github.com/amix/vimrc.git $HOME/.vim_runtime
#     New-Item -ItemType HardLink -Force -Path $HOME -Name .vimrc -Value $HOME\.vim_runtime\vimrcs\basic.vim | Out-null
# }

# Write-Output "Opening firefox for manual installers"
# firefox "https://www.sync.com/download/win/sync-installer.exe"
# firefox "https://addons.mozilla.org/en-US/firefox/addon/lastpass-password-manager/"
# firefox "https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/"

# Invoke-Expression "$PSScriptRoot\\Win10-Initial-Setup-Script\\Win10.ps1 -preset $PSScriptRoot\\config\\Win10.preset -include $PSScriptRoot\\Win10-Initial-Setup-Script\\Win10.psm1"
