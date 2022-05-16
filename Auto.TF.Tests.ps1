Describe 'Auto.TF.Tests' {
    It 'passes tf bad test' {
        $source = "$PSScriptRoot\data\smokeX"
        Write-Verbose "source:$source"
        {. .\Auto.ps1 tf $source -Verbose} | Should -Throw
    }
    It 'passes tf smoke test' {
        set-location $PSScriptRoot
        $source = "$PSScriptRoot\data\tasks\smoke"
        #$source = 'smoke'
        Write-Verbose "source:$source"
        $results = (. .\Auto.ps1 tf $source -Verbose) 
        $results | Should -Not -BeNullOrEmpty
        $results | Should -Not -BeLike '*error* but found: $results'
        $? | Should -Be $true
    }
    It 'passes tf k8s' {
        $source = "$PSScriptRoot\data\tf\k8s"

        #$results = .\Auto.ps1 az $source -Verbose | Should -Not -BeNullOrEmpty
        $results | Should -Not -BeLike '*error*'
        $? | Should -Be $true
    }
    It 'passes tf test' {
        $source = "$PSScriptRoot\data\tf"

        #$results = .\Auto.ps1 az $source -Verbose | Should -Not -BeNullOrEmpty
        $results | Should -Not -BeLike '*error*'
        $? | Should -Be $true
    }
}
