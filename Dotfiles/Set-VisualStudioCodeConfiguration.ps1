function Set-VisualStudioCodeConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    $CodeSettingsFile = Join-Path -Path (Get-DotfilesLocation) -ChildPath '/config/vscode/settings.json'
    New-Item -Type HardLink -Force -Path $env:APPDATA\Code\User -Name settings.json -Target $CodeSettingsFile | Out-Null
}