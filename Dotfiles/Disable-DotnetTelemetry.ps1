<#
.SYNOPSIS

Opt out from .NET Telemetry.
Read more about .NET CLI Tools telemetry: https://aka.ms/dotnet-cli-telemetry

.EXAMPLE

PS> Disable-DotnetTelemetry

#>
function Disable-DotnetTelemetry {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    $OptOutKey = "DOTNET_CLI_TELEMETRY_OPTOUT"
    $DesiredValue = 1
    $OptOutCurrentValue = [System.Environment]::GetEnvironmentVariable($OptOutKey, "User")

    if ($OptOutCurrentValue -eq $null) {
        if($PSCmdlet.ShouldProcess("Opt out from .NET Telemetry by setting environment variable $OptOutKey",  "$OptOutKey", "Add")){
            [System.Environment]::SetEnvironmentVariable($OptOutKey, $DesiredValue, "User")
        }
    } elseif ($OptOutCurrentValue -ne $DesiredValue) {
        if($PSCmdlet.ShouldProcess("Change value of .NET Telemetry opt out from $OptOutCurrentValue to $DesiredValue",  "$OptOutKey", "Update")){
            [System.Environment]::SetEnvironmentVariable($OptOutKey, $DesiredValue, "User")
        }
    }
}