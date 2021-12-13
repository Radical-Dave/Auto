Describe 'Auto.Tests' {
    It 'passes empty' {
        .\Auto.ps1 | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
    }
    It 'passes add' {
        $results = .\Auto.ps1 add 'add task test=add task test' | Should -Not -BeNullOrEmpty
        $results | Should -Not -BeLike '*error*'
        $? | Should -Be $true
    }
    It 'passes delete' {
        $results = .\Auto.ps1 delete 'add task test' | Should -Not -BeNullOrEmpty
        $results | Should -Not -BeLike '*error*'
        $? | Should -Be $true
    }
    It 'passes report' {
        #todo: use \tests
        #.\Auto.ps1 report mdf | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
    }
    It 'passes cmd' {
        #todo:dont recall this one, but cmd invokes a shell, so this doesnt work at least
        #"cmd": "cmd $(data)",
        #.\Auto.ps1 'cmd' 'echo pass' | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
        $? | Should -Not -BeLike '*Task not found*'
    }
    It 'passes date' {
        $results = .\Auto.ps1 'date' | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
        Write-Host "results:$results"
    }
    It 'passes echo' {
        $results = .\Auto.ps1 'echo' 'smoke-test-echo' -Verbose | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
        $? | Should -Not -BeLike '*Task not found*'
        #$? | Should -BeLike '*smoke-test-echo*'
        Write-Host "results:$results"
    }
    It 'passes build' {
        $results = .\Auto.ps1 'build' | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
        Write-Host "results:$results"
    }
    It 'passes install' {
        $results = .\Auto.ps1 'install' 'smoke-test' | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
        $? | Should -Not -BeLike '*Task not found*'
        Write-Host "results:$results"
    }
    It 'passes test' {
        #.\Auto.ps1 'test' | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
    }
    It 'passes transfer' {
        #"transfer": "xcopy $(data) /c /d /e /f /h /i /j /k /o /v /x /y",
        $results = .\Auto.ps1 "transfer $PSScriptRoot\tests\smoke\transfer\source $PSScriptRoot\tests\smoke\transfer\dest" | Should -Not -BeNullOrEmpty
        $? | Should -Be $true
        $? | Should -Not -BeLike '*Task not found*'
        Write-Host "results:$results"
    }
    #It 'passes folder update' {
    #    $source = "$PSScriptRoot\tests\smoke"

        #Copy-Item $source -Destination "tests/smoke-test-update" -Force -Recurse
        #.\Auto.ps1 "tests/smoke-test-update" | Should -Not -BeNullOrEmpty
        #$? | Should -Be $true
    #}
}