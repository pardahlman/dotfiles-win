BeforeAll {
    . $PSScriptRoot/Import-ScoopManifest.ps1
    . $PSScriptRoot/Install-ScoopApps.ps1
    . $PSScriptRoot/Mock-NativeApplications.ps1
    . $PSScriptRoot/Test-ScoopInstalled.ps1
}

Describe "Install-ScoopApps" {
    It "Throws exception if Scoop is not installed" {
        # Arrange
        Mock Test-ScoopInstalled { return $false }

        # Act + Assert
        { Install-ScoopApps "./scoop.json" } | Should -Throw -ExpectedMessage "Unable to install Scoop apps. Scoop is not installed"
    }

    It "Throws exception if Scoop manifest file not found" {
        # Arrange
        $ManifestPath = "/config/scoop.json"
        Mock Test-ScoopInstalled { return $true }
        Mock Test-Path { return $false } -ParameterFilter { $args[0] -eq $ManifestPath }

        # Act + Assert
        { Install-ScoopApps $ManifestPath } | Should -Throw -ExpectedMessage "Unable to install Scoop apps. Path $ManifestPath not found"
    }

    It "Imports Scoop manifest with provided path" {
        # Arrange
        $ManifestPath = "/config/scoop.json"
        Mock Test-ScoopInstalled { return $true }
        Mock Test-Path { return $true }
        Mock Import-ScoopManifest { Write-Host "Scoop called with $args" }

        # Act
        Install-ScoopApps $ManifestPath

        # Assert
        Should -Invoke -CommandName Import-ScoopManifest -Exactly -Times 1 -ParameterFilter { $ManifestLocation -eq $ManifestPath }
    }
}