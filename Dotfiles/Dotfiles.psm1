. $PSScriptRoot/Get-DotfilesLocation.ps1

$PublicFunctions = Get-ChildItem | Where-Object { $_.Name -notlike "*.Tests.ps1" }
$PrivateFunctions = Get-ChildItem | Where-Object { $_.Name -notlike "*.Tests.ps1" }

foreach ($ScriptFile in @($PublicFunctions + $PrivateFunctions)) {
    try {
        . $ScriptFile.FullName
    }
    catch {
        Write-Error -Message "Failed to import function $($ScriptFile.FullName): $_"
    }
}

Export-ModuleMember -Function $PublicFunctions.Basename -Alias *