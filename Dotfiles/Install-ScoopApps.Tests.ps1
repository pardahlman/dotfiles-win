BeforeAll {
    . $PSScriptRoot/Private/Invoke-Scoop.ps1
    . $PSScriptRoot/Install-ScoopApps.ps1
    . $PSScriptRoot/Private/Test-CommandExist.ps1
    . $PSScriptRoot/Private/Mock-NativeApplications.ps1
}

Describe "Install-ScoopApps" {
    It "Throws exception if Scoop is not installed" {
        # Arrange
        Mock Test-CommandExist { return $false }

        # Act + Assert
        { Install-ScoopApps "./scoop.json" } | Should -Throw -ExpectedMessage "Unable to install Scoop apps. Scoop is not installed"
    }

    It "Throws exception if Scoop manifest file not found" {
        # Arrange
        $ManifestPath = "/config/scoop.json"
        Mock Test-CommandExist { return $true }
        Mock Test-Path { return $false } -ParameterFilter { $args[0] -eq $ManifestPath }

        # Act + Assert
        { Install-ScoopApps $ManifestPath } | Should -Throw -ExpectedMessage "Unable to install Scoop apps. Path $ManifestPath not found"
    }

    It "Imports Scoop manifest with provided path" {
        # Arrange
        $ManifestPath = "/config/scoop.json"
        Mock Test-CommandExist { return $true }
        Mock Test-Path { return $true }
        Mock Invoke-Scoop { }

        # Act
        Install-ScoopApps $ManifestPath

        # Assert
        Should -Invoke -CommandName Invoke-Scoop -Exactly -Times 1 -ParameterFilter { $Command -eq "import" -and $Arguments -eq $ManifestPath }
    }
}