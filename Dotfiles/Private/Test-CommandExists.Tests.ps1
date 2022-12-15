BeforeAll {
    . $PSScriptRoot/Test-CommandExists.ps1
}

Describe "Test-CommandExists" {
    It "Returns false for non-existing command" {
        Test-CommandExists non-existing | Should -Be $false
    }

    It "Returns true for existing command" {
        Test-CommandExists curl | Should -Be $true
    }

    It "Returns true for existing command name" {
        Test-CommandExists "curl" | Should -Be $true
    }
}