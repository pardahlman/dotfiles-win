BeforeAll {
    . $PSScriptRoot/Test-CommandExist.ps1
}

Describe "Test-CommandExist" {
    It "Returns false for non-existing command" {
        Test-CommandExist non-existing | Should -Be $false
    }

    It "Returns true for existing command" {
        Test-CommandExist curl | Should -Be $true
    }

    It "Returns true for existing command name" {
        Test-CommandExist "curl" | Should -Be $true
    }
}