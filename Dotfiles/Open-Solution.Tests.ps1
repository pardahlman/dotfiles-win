BeforeAll {
    . $PSScriptRoot/Open-Solution.ps1
}

Describe "Open-Solution" {
    It "Opens the only sln file in the path when no pattern is provided" {
        # Arrange
        $SlnName = "Test.sln"
        New-Item -Path "TestDrive:\1\$SlnName" -Force
        Mock Invoke-Expression

        # Act
        Open-Solution2 -Path "TestDrive:\1"

        # Assert
        Should -Invoke -CommandName Invoke-Expression -ParameterFilter { $Command -like "*$SlnName" }
    }

    It "Does not open any solution if provided path does not match sln file" {
        # Arrange
        New-Item -Path "TestDrive:\2\Test.sln" -Force
        Mock Invoke-Expression

        # Act
        Open-Solution2 -Pattern "None-Match" -Path "TestDrive:\2"

        # Assert
        Should -Invoke -CommandName Invoke-Expression -Times 0
    }
}
