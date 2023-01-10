function Install-ScoopApps {
    Param($JsonManifest)
    if (-not (Test-ScoopInstalled)) {
        throw "Unable to install Scoop apps. Scoop is not installed"
    }

    if (-not (Test-Path -Path $JsonManifest)) {
        throw "Unable to install Scoop apps. Path $JsonManifest not found"
    }

    Import-ScoopManifest $JsonManifest 6> $null
}