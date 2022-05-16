Describe 'Auto.Sql.Tests' {
    It 'passes sql smoke test' {
        $results = (.\Auto.ps1 'sql' -Verbose) 
        $results | Should -Not -BeNullOrEmpty
        $results | Should -Not -BeLike '*error* but found: $results'
        $? | Should -Be $true
    }
}
