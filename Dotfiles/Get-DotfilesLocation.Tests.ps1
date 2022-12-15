BeforeAll {
    . $PSScriptRoot/Get-DotfilesLocation.ps1
}

Describe "Get-DotfilesLocation" {
    It "Returns parent directory from which it is defined" {
        Mock Get-Location { return "C:\DotfilesRoot\DotfilesModule" }
        Get-DotfilesLocation | Should -Be "C:\DotfilesRoot"
    }
}