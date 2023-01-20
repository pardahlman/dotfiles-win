function Set-VimConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    $Vimrc = Join-Path -Path (Get-DotfilesLocation) -ChildPath '/config/vim/vimrc'
    New-Item -ItemType HardLink -Force -Path $HOME -Name .vimrc -Value $Vimrc | Out-Null
}