function Test-CommandExist {
    Param($CommandName)
    return [bool](Get-Command -Name $CommandName -ErrorAction SilentlyContinue)
}