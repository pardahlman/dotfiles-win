<#
.SYNOPSIS

Opens dotfiles folder in Visual Studio Code

.EXAMPLE

PS> Edit-Dotfiles

#>
function Edit-Dotfiles {
    $DotfilesLocation = Get-DotfilesLocation
    if (Test-CommandExists "code") {
        & code $DotfilesLocation
    }
    else {
        Write-Warning "Visual Studio Code is not found. Opening directory instead"
        Invoke-Item -Path $DotfilesLocation
    }
}