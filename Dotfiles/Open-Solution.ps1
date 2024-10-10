<#
.SYNOPSIS

Open a .NET Solution file based on fuzzy matching.

.DESCRIPTION

Open a .NET Solution file based on fuzzy matching.

.PARAMETER Pattern
A pattern used to match any solution file (*.sln) containing the
provided pattern.

.EXAMPLE

PS> > os
Multiple matching solutions found:
foo.sln
bar.sln
baz.sln

.EXAMPLE

PS> os fo
Opening foo.sln...
#>
function Open-Solution2 {
    [Alias("os")]
    Param ([string] $Pattern, [int] $Depth = 2)
    if (Test-Path -Path $Pattern -PathType Leaf) {
        $ExactMatch = Get-ChildItem $Pattern
        Write-Host "Opening $($ExactMatch.Name)..."
        Invoke-Expression "& $($ExactMatch.FullName)" | Out-Null
        return
    }
    $SingleMatch = Get-ChildItem -Recurse -Filter "$Pattern.sln" -Depth $Depth
    if ($SingleMatch) {
        Write-Host "Opening $($SingleMatch.Name)..."
        Invoke-Expression "& $($SingleMatch.FullName)" | Out-Null
        return
    }
    $MatchingSlnFiles = Get-ChildItem -Recurse -Filter "*$Pattern*.sln" -Depth $Depth
    if ($MatchingSlnFiles.Count -eq 0) {
        Write-Host "No matching solution found"
        return
    }
    if ($MatchingSlnFiles.Count -gt 1) {
        Write-Host "Multiple matching solutions found:"
        $MatchingSlnFiles | ForEach-Object { $_.Name }
        return
    }
    $matchingSlnFile = $MatchingSlnFiles[0]
    Write-Host "Opening $($matchingSlnFile.Name)..."
    Invoke-Expression "& $($matchingSlnFile.FullName)" | Out-Null
}
