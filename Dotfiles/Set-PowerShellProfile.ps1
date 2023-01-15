function Set-PowerShellProfile {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    $PowerShellProfile = Join-Path -Path (Get-DotfilesLocation) -ChildPath '/config/pwsh/Microsoft.PowerShell_profile.ps1'
    New-Item -ItemType HardLink -Force -Path $PROFILE -Target $PowerShellProfile | Out-Null
}