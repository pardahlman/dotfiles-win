BeforeAll {
    . $PSScriptRoot/Edit-Dotfiles.ps1
    . $PSScriptRoot/Get-DotfilesLocation.ps1
    . $PSScriptRoot/Private/Test-CommandExist.ps1
}

Describe "Edit-Dotfiles" {
    It "Opens Visual Studio Code with directory from Get-DotfilesLocation" {
        # Arrange
        $DotfilesLocation = "C:\DotfilesRoot\"
        Mock Test-CommandExist { return $true } -ParameterFilter { $CommandName -eq "code" }
        Mock Get-DotfilesLocation { return $DotfilesLocation }
        Mock "code" { }

        # Act
        Edit-Dotfiles

        # Assert
        Should -Invoke -CommandName "code" -Exactly -Times 1 -ParameterFilter { $args[0] -eq $DotfilesLocation }
    }

    It "Opens directory if Visual Studio Code not found" {
        # Arrange
        $DotfilesLocation = "C:\DotfilesRoot\"
        Mock Test-CommandExist { return $false } -ParameterFilter { $CommandName -eq "code" }
        Mock Get-DotfilesLocation { return $DotfilesLocation }
        Mock Invoke-Item { }

        # Act
        Edit-Dotfiles

        # Assert
        Should -Invoke -CommandName 'Invoke-Item' -Exactly -Times 1  -ParameterFilter { $Path -eq $DotfilesLocation }
    }
}