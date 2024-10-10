<#
.SYNOPSIS

Add or update Git configuration to provided target path by creating hard links
for the following files:

.gitignore: default ignore settings
.gitattrubutes: default git attributes
.gitconfig: alias etc.
.gitconfig.delta: configuration for delta

A file .gitignore.local is created if one does not exist.

.EXAMPLE

PS> Instal-ScoopApps .\scoop.json

#>
function Set-GitConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param([string]$TargetPath)

    if(-not $TargetPath)
    {
        Write-Information "No target path provided, defaulting to $HOME"
        $TargetPath = $HOME
    }

    $GitConfigPath = Join-Path -Path (Get-DotfilesLocation) -ChildPath '/config/git'
    New-Item -ItemType HardLink -Force -Path $TargetPath -Name .gitignore -Value $GitConfigPath\gitignore | Out-Null
    New-Item -ItemType HardLink -Force -Path $TargetPath -Name .gitattributes -Value $GitConfigPath\gitattributes | Out-Null
    New-Item -ItemType HardLink -Force -Path $TargetPath -Name .gitconfig -Value $GitConfigPath\gitconfig | Out-Null
    New-Item -ItemType HardLink -Force -Path $TargetPath -Name .gitconfig.delta -Value $GitConfigPath\gitconfig.delta | Out-Null

    if (Test-Path $TargetPath\.gitconfig.local) {
        Write-Debug "Local git configuration found"
    }
    else {
        copy -Path $GitConfigPath\gitconfig.local -Destination $TargetPath\.gitconfig.local | Out-Null
    }
}