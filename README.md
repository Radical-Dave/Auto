# Auto
## Description
Auto All The Things!

## Installation (Powered by [PowerShellGallery](https://powershellgallery.com/packages/Auto))
PS>
```ps
Install-Script Auto
```

## Examples
PS> 
```ps
Auto -help
```

PS>
```ps
Auto
```

PS>
```ps
Auto tf smoke-test
```
PS>
```ps
Auto az smoke-test
```

## Release Notes
- 0.1 init
- 0.2 added mode: Full,Init,Plan,Apply
- 0.3 added path param
- 0.4 fixed paths and added $error checks
- 0.5 added mode: Clean
- 0.6 added -ErrorAction "SilentlyContinue" on remove-items and Write-Verbose
- 0.7 added clean to init
- 0.8 added -compact-warnings -input=false
- 0.9 added *.tfplan to clean
- 0.10 added test-path tfplan
- 0.11 added options
- 0.12 path fixes
- 0.13 updates
- 0.14 data folder write-host
- 0.15 base path fix
- 0.16 revert base change
- 0.17 added PSScriptRoot verbose
- 0.18 try catch around tasks
- 0.19 clean up
- 0.20 

## Copyright
David Walker, [Radical Dave](https://github.com/radical-dave), [Sitecore Dave](https://github.com/sitecoredave)

## License
MIT License: https://github.com/Radical-Dave/Auto/blob/main/LICENSE
