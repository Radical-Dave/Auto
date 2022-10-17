$filter = "*.tf"
$data = "d:/repos/powershell/auto/data/providers/tf"
$cwd= $PWD
$folders = Get-ChildItem -exclude ".*" -Path $data -Recurse | Where-Object {$_.PSIsContainer}# | ForEach-Object {
foreach($folder in $folders) {
    if (Test-Path "$folder\$filter") {
        Write-Host "found:{$folder}"
        Set-Location $_.FullName -verbose
        Invoke-Expression -Command $action -OutVariable $results
    }
}
Set-Location $cwd