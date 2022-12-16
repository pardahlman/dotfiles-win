$PublicFunctions = Get-ChildItem -Path $PSScriptRoot -File -Filter "*.ps1" | Where-Object { $_.Name -notlike "*.Tests.ps1" }
$PrivateFunctions = Get-ChildItem -Path "$PSScriptRoot\Private" -File -Filter "*.ps1" | Where-Object { $_.Name -notlike "*.Tests.ps1" }

foreach ($ScriptFile in @($PublicFunctions + $PrivateFunctions)) {
    try {
        . $ScriptFile.FullName
    }
    catch {
        Write-Error -Message "Failed to import function $($ScriptFile.FullName): $_"
    }
}

Export-ModuleMember -Function $PublicFunctions.Basename -Alias *