$RepositoryUrl = "https://github.com/pardahlman/dotfiles-windows.git"
$InstallDirectory = "$HOME/.dotfiles"

if(Test-Path $InstallDirectory){
    Write-Host "Directory $SetupFile already exists. To continue, remove directory and try again."
    exit 1;
}

if (-ne (Get-Command scoop -errorAction SilentlyContinue))
{
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

if (-ne (Get-Command git -errorAction SilentlyContinue))
{
    scoop install git
}

scoop bucket add extras
git clone $RepositoryUrl $InstallDirectory
Invoke-Expression "$InstallDirectory\setup.ps1"
