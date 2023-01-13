function Get-DotfilesLocation {
    # Assume this file is located in root of module
    $ModulePath = Get-Item ($PSScriptRoot)

    if($ModulePath.LinkType -eq 'Junction')
    {
        $ModulePath = Select-Object -InputObject $ModulePath -ExpandProperty Target | Get-Item
    }
    return $ModulePath.FullName | Split-Path
}
