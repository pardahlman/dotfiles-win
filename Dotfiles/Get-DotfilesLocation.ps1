function Get-DotfilesLocation {
    # Assume this file is located in root of module
    $DotfilesModulePath = Get-Item ($PSScriptRoot)

    if($DotfilesModulePath.LinkType -eq 'Junction')
    {
        $DotfilesModulePath = Select-Object -InputObject $DotfilesModulePath -ExpandProperty Target | Get-Item
    }
    return $DotfilesModulePath.FullName | Split-Path
}
