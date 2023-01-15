<#
.SYNOPSIS

Install Scoop apps using 'scoop import'.

.EXAMPLE

PS> Instal-ScoopApps .\scoop.json

#>
function Install-ScoopApps {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    Param($JsonManifest)
    if (-not (Test-CommandExist "scoop")) {
        throw "Unable to install Scoop apps. Scoop is not installed"
    }

    if (-not (Test-Path -Path $JsonManifest)) {
        throw "Unable to install Scoop apps. Path $JsonManifest not found"
    }

    Invoke-Scoop import $JsonManifest #6> $null
}