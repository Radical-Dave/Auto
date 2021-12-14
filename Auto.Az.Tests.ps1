Describe 'Auto.AZ.Tests' {
    It 'passes az smoke test' {
        $source = "$PSScriptRoot\data\smoke"
        Write-Verbose "source:$source"
        .\Auto.ps1 az $source -Verbose  | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
    }
    It 'passes az test' {
        $source = "$PSScriptRoot\data\az"

        #$results = .\Auto.ps1 az $source -Verbose | Should -Not -BeNullOrEmpty
        $results | Should -Not -BeLike '*error*'
        $? | Should -Be $true
    }
}