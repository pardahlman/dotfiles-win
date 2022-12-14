$ErrorActionPreference = 'Stop'

$RepositoryUrl = "https://github.com/pardahlman/dotfiles-win.git"
$InstallDirectory = "$HOME/.dotfiles"

if(Test-Path $InstallDirectory){
    Write-Host "Directory $SetupFile already exists. To continue, remove directory and try again."
    exit 1;
}

if (-not (Get-Command scoop -ErrorAction SilentlyContinue))
{
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

if (-not (Get-Command git -ErrorAction SilentlyContinue))
{
    scoop install git
}

scoop bucket add extras
git clone --recurse-submodules $RepositoryUrl $InstallDirectory
Invoke-Expression "$InstallDirectory\setup.ps1"
