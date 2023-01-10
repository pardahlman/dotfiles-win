function Write-DotfilesStatus {
    $DotfilesLocation = Get-DotfilesLocation
    $GitStatus = ""

    try {
        Push-Location $DotfilesLocation
        $GitStatus = (Invoke-Git status -b --porcelain=v2) -join ""
    }
    catch { Write-Error "Failed to write Dotfiles status: $($Error[0])" }
    finally { Pop-Location }

    # branch.oid (?<commitId>[0-9a-z]{12})
    # branch.head (?<head>[^#]*)#
    # branch.ab (\+(?<ahead>\d*))? (-(?<behind>\d*))
    $CommitId = ($GitStatus -match "# branch.oid (?<commitId>[0-9a-z]{12})") ? $Matches["commitId"] : "N/A"
    $Head = ($GitStatus[1] -match '# branch.head (?<head>.*)') ? $Matches["head"] : "N/A"
    if($Head -ne 'main')
    {
        Write-Host "Dotfiles not using main branch. HEAD is at $HEAD"
        return
    }
    
    $Ahead = 0
    $Behind = 0
    if($GitStatus -match "# branch.ab (\+(?<ahead>\d*))? (-(?<behind>\d*))")
    {
        $Ahead = $Matches["ahead"]
        $Behind = $Matches["behind"]
    }

    Write-Host "Dotfiles are $Behind commits behind and $Ahead ahead"
}