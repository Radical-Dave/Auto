$PSScriptName = ($MyInvocation.MyCommand.Name.Replace(".ps1",""))
$PSCallingScript = if ($MyInvocation.PSCommandPath) { $MyInvocation.PSCommandPath | Split-Path -Parent } else { $null }
Write-Verbose "#####################################################"
Write-Host "# $($PSScriptName):$action $data $path called by:$PSCallingScript" -ForegroundColor White