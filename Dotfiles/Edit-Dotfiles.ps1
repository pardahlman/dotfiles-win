<#
.SYNOPSIS

Opens dotfiles folder in Visual Studio Code

.EXAMPLE

PS> Edit-Dotfiles

#>
function Edit-Dotfiles {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    Param()

    $DotfilesLocation = Get-DotfilesLocation
    if (Test-CommandExist "code") {
        & code $DotfilesLocation
    }
    else {
        Write-Warning "Visual Studio Code is not found. Opening directory instead"
        Invoke-Item -Path $DotfilesLocation
    }
}