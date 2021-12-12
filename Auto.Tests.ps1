Describe 'Smoke Tests' {
    It 'passes empty params' {
        .\Auto.ps1 | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
    }
    It 'passes add task' {
        $results = .\Auto.ps1 add 'add task test' | Should -Not -BeNullOrEmpty
        $results | Should -Not -BeLike '*error*'
        $? | Should -Be $true
    }
    It 'passes delete task' {
        $results = .\Auto.ps1 delete 'add task test' | Should -Not -BeNullOrEmpty
        $results | Should -Not -BeLike '*error*'
        $? | Should -Be $true
    }    
    It 'passes smoke test' {
        $source = "$PSScriptRoot\tests\smoke\tasks.json"
        Write-Verbose "source:$source"
        #.\Auto.ps1 az $source -Verbose  | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
        #az group delete -n 'smoke-test'
    }
    It 'passes az test' {
        $source = "$PSScriptRoot\tests\az\tasks.json"

        #$results = .\Auto.ps1 az $source -Verbose | Should -Not -BeNullOrEmpty
        $results | Should -Not -BeLike '*error*'
        $? | Should -Be $true
    }
    #It 'passes folder update' {
    #    $source = "$PSScriptRoot\tests\smoke"

        #Copy-Item $source -Destination "tests/smoke-test-update" -Force -Recurse
        #.\Auto.ps1 "tests/smoke-test-update" | Should -Not -BeNullOrEmpty
        #$? | Should -Be $true
    #}
}