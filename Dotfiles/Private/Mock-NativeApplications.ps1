. $PSScriptRoot/Test-CommandExist.ps1

if (-not (Test-CommandExist "code")) {
    function code {}
}

if (-not (Test-CommandExist "git")) {
    function git {}
}

if (-not (Test-CommandExist "scoop")) {
    function scoop {}
}