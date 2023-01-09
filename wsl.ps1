# TODO: Verify that WSL is installed with Ubuntu running

Push-Location $PSScriptRoot
try {
    wsl -d Ubuntu -e ./wsl.sh $env:USERNAME
}
finally {
    Pop-Location
}
