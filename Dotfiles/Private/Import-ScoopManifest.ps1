function Import-ScoopManifest {
    Param([string]$ManifestLocation)
    & scoop import $ManifestLocation
}