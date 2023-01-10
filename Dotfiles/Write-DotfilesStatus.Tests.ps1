BeforeAll {
    . $PSScriptRoot/Get-DotfilesLocation.ps1
    . $PSScriptRoot/Write-DotfilesStatus.ps1
    . $PSScriptRoot/Private/Invoke-Git.ps1
}

Describe "Write-DotfilesStatus" {
    It "Extracts status from git" -ForEach @(
        @{ RawStatus = @("# branch.oid 6d07b93c85f2604a3c3c8f5aad8e91f6f147739e", "# branch.head main", "# branch.ab +1 -136"); Expected = "Dotfiles are 136 commits behind and 1 ahead" }
        @{ RawStatus = @("# branch.oid 55f1f65e9554267a323124f265587b48190eb6ff", "# branch.head (detached)"); Expected = "Dotfiles not using main branch. HEAD is at (detached)" }
    ) {
        # Arrange
        Mock Get-DotfilesLocation { return "" }
        Mock Invoke-Git { return $RawStatus }
        Mock Write-Host {}

        # Act
        Write-DotfilesStatus

        # Assert
        Should -Invoke -CommandName Write-Host -Times 1 -ParameterFilter { $Object -eq $Expected }
    }
}