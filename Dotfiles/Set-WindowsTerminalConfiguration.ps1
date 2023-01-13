<#
.SYNOPSIS

Updates Windows Terminal configuration by adding or replacing settings.json with
a bare-to the bone version. This is done by coping the configuration files rather
than creating a HardLink, as Windows Terminal repeatedly updates the settings
with several default values that can not be removed.

.EXAMPLE

PS> Set-WindowsTerminalConfiguration

#>
function Set-WindowsTerminalConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param()
    $DotfilesLocation = Get-DotfilesLocation
    Copy-Item -Path $DotfilesLocation\config\windows-terminal\settings.json -Destination "$Env:LocalAppData\Microsoft\Windows Terminal\settings.json"
}
