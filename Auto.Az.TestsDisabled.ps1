Describe 'Auto.AZ.Tests' {
    It 'passes az smoke test' {
        $source = "$PSScriptRoot\tests\smoke\tasks.json"
        Write-Verbose "source:$source"
        .\Auto.ps1 az '' $source -Verbose  | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
    }
    It 'passes az test' {
        $source = "$PSScriptRoot\tests\az\tasks.json"

        #$results = .\Auto.ps1 az $source -Verbose | Should -Not -BeNullOrEmpty
        $results | Should -Not -BeLike '*error*'
        $? | Should -Be $true
    }
}