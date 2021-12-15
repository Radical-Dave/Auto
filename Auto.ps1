#Set-StrictMode -Version Latest
#####################################################
# Auto
#####################################################
<#PSScriptInfo

.VERSION 0.11

.GUID 602bc07e-a621-4738-8c27-0edf4a4cea8e

.AUTHOR David Walker, Sitecore Dave, Radical Dave

.COMPANYNAME David Walker, Sitecore Dave, Radical Dave

.COPYRIGHT David Walker, Sitecore Dave, Radical Dave

.TAGS sitecore powershell local install iis solr

.LICENSEURI https://github.com/SitecoreDave/SharedSitecore.SitecoreLocal/blob/main/LICENSE

.PROJECTURI https://github.com/SitecoreDave/SharedSitecore.SitecoreLocal

.ICONURI

.EXTERNALMODULEDEPENDENCIES

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES


#>

<#
.SYNOPSIS
Auto All The Things!

.DESCRIPTION
PowerShell script that helps you Automate All The Things!

.EXAMPLE
PS> Auto 'name'

PS> Auto az armtemplate.json

.EXAMPLE
PS> Auto 'name' 'template'

.EXAMPLE
PS> Auto 'name' 'template' 'd:\repos'

.Link
https://github.com/Radical-Dave/Auto

.OUTPUTS
    System.String
#>
[CmdletBinding(SupportsShouldProcess=$true)]
Param(
	[Parameter(Mandatory = $false, Position=0)]
	[string] $action = "help",
	[Parameter(Mandatory = $false, Position=1)]
	[string] $data = "",
	[Parameter(Mandatory = $false, Position=2)]
	[string] $path = "",
	[switch] $Force = $false
)
begin {
	$PSScriptName = ($MyInvocation.MyCommand.Name.Replace(".ps1",""))
	$PSCallingScript = if ($MyInvocation.PSCommandPath) { $MyInvocation.PSCommandPath | Split-Path -Parent } else { $null }
	Write-Verbose "#####################################################"
	Write-Host "# $($PSScriptName):$action $data $path called by:$PSCallingScript" -ForegroundColor White

	$StopWatch = New-Object -TypeName System.Diagnostics.Stopwatch
	$StopWatch.Start()

	if (!$path) {
		if (Test-Path "$PSScriptRoot\$PSScriptName.json") {
			$path = "$PSScriptRoot\$PSScriptName.json"
		} else {
			$profileParent =Split-Path $profile -Parent
			if (Test-Path "$profileParent\$($PSScriptName).json") {
				$path = "$profileParent\$($PSScriptName).json"
			}
		}
	}
	
	Write-Verbose "path:$path"
	#if (!(Test-Path $path)) {
	#	throw "ERROR invalid path:$($path)"
	#}

	if ($path) {
		try {
			#$tasks = Get-Content .\auto.json | Out-String | Invoke-Expression
			$config = (Get-Content $path -Raw) | ConvertFrom-Json
			#Write-Host "config:$($config)"
		} catch {
			throw $_
		}
		Write-Verbose "logs:$($config.logs)"
		$tasksNode = $config.psobject.properties["tasks"].value
		#Write-Host "tasksNode:$($tasksNode)"
		$tasks = $tasksNode.PSObject.Properties
		#Write-Host "tasks:$($tasks)"
	}
}
process {
	if ($action -eq 'add' -and $data.IndexOf('=') -gt -1) {
		Write-Host "add task:$data"
		$ds = $data.split('=')
		#if ($config.tasks["$data"]) {
			#if (!Force) {
			#	throw "ERROR Task:$action already exists. Use -Force to overwrite."
			#} else {
			#	$config.tasks | Add-Member -MemberType NoteProperty -Name "$($ds[0])" -Value "$($ds[1])" -PassThru -Force
			#}
		#} else {
			$config.tasks | Add-Member -MemberType NoteProperty -Name "$($ds[0])" -Value "$($ds[1])" -PassThru -Force
		#}
		$config | ConvertTo-Json | Out-File $path
	} elseif ($action -eq 'del' -or $action -eq 'delete' -and $data) {
		if (!$config -or !$config.tasks) {
			throw 'ERROR no config or config.tasks?'
		}
		Write-Host "delete task:$data"
		$config.tasks.PSObject.Properties.Remove("$data")
		$config | ConvertTo-Json | Out-File $path
	} else {
		$task = @()
		if ($tasks -and $action -ne 'help') {
			$taskProperty = $tasks[$action]
			if ($taskProperty) {
				$task = $taskProperty.value
			}
		}
		if ($task) {
			Write-Verbose "task:$task"
			if ($task -like '*$(data)*') {
				Write-Verbose "data:$data"
				$task = $task.replace('$(data)', "$($data)")
				#$task = $task -replace '$(data)', "$($data)"
			}
			Write-Verbose "task:$task"
			$cmd = $task
			Write-Verbose "cmd:$cmd"
			if ($cmd -like '~\*') {
				$cmd = (Join-Path (Split-Path $profile -Parent) ($task.Remove(0,2)))
			} elseif ($cmd -like '.\*') {
				$cmd = (Join-Path $PSScriptRoot ($task.Remove(0,2)))
			} elseif ($cmd.Substring(0,2) -eq '*\') {
				$name = $cmd.Remove(0,2)
				Write-Host "name:$name"
				$checkPath = $data
				if (!$checkPath) {
					#$cmd = (Join-Path $PSScriptRoot ($task.Remove(0,2)))
					$checkPath = "$(Split-Path $path -Parent)\data\tests\nested"
				}				
				
				Write-Host "checkPath:$checkPath"
				$cmd = Get-ChildItem "$checkPath\$name*" -Recurse | Select-Object FullName
				if (!$cmd) {
					throw "ERROR could not find item $name in $checkPath -Recurse"
				}
			}
			Write-Host "Invoke:$cmd" -ForegroundColor White
			if (!$data) {
				Invoke-Expression -Command $cmd -OutVariable $results
			} else {
				Invoke-Expression -Command "$cmd $data" -OutVariable $results
			}
			Write-Host "RESULTS:$results"
		} else {
			if ($action -ne 'help' -and $action -ne 'az') {
				Write-Host "Task not found in $PSScriptName.json: $action, to add use: -addTask 'AutoScript'" -ForegroundColor White
			}
			if ($action -eq 'az') {
				Write-Host "RUN:$path"

				#todo: finish working with Nick to use set-env (otherwise use set-envs)
				@((Split-Path $profile -Parent),$PSScriptRoot,("$currLocation" -ne "$PSScriptRoot" ? $currLocation : ''),$data).foreach({
					try {
						$p = $_
						if ($p) {
							#Write-Verbose "checking:$p\*.env*"
							if (Test-Path $p\*.env*) {
								Get-ChildItem –Path $p\*.env* | Foreach-Object {
									try {
										$f = $_
										#Write-Verbose "checking:$($f.FullName)"							
										$content = (Get-Content $f.FullName)
										$content | ForEach-Object {
											if (-not ($_ -like '#*') -and  ($_ -like '*=*')) {
												$sp = $_.Split('=')
												#Write-Host "Set-Env $($sp[0])=$($sp[1])"
												[System.Environment]::SetEnvironmentVariable($sp[0], $sp[1])
											}
										}
									}
									catch {
										Write-Error "ERROR Set-Env $p-$f" #-InformationVariable results
									}
								}
							} else { 
								#Write-Verbose "skipped:$p no *.env* files found"
							}
						}
					}
					catch {
						Write-Error "ERROR Set-Env $p" #-InformationVariable results
					}
				})

				if (!$prefix) { $prefix = $env:prefix }
				if (!$prefix) { $prefix = $env:RELEASE_DEFINITIONNAME }
				if (!$prefix) { $prefix = 'az' }

				if (!$envName) { $envName = $env:envName }
				if (!$envName) { $envName = $env:RELEASE_ENVIRONMENTNAME}
				if (!$envName) { $envName = 'test'}
				
				if (!$location) { $location = $env:location }
				if (!$location) {$location = 'eastus'}

				if (!$armconfig) { $armconfig = 'default'}

				$myResourceGroupName="$prefix-$envName"
				Write-Host "deploying:$($myResourceGroupName)"

				#az group create --name $myResourceGroupName --location $location
				
				if ($data -and (Test-Path "$data")) {
					$deployment = $data
					$base = Split-Path $deployment -Parent
				} else {
					$base = "$(Get-Location)\data"
					if (!(Test-Path $base)) {
						$base = "$PSScriptRoot\data"
					}
				}
				if (!(Test-Path $base)) {
					throw "data not found:$base"
				}
				Write-Host "base:$base"

				#todo:test-paths, az is always base, but checking for customs
				$deployment = "$base\$prefix-$envName"
				if (!(Test-Path $deployment)) {
					$deployment ="$base\$prefix"
				}
				if (!(Test-Path "$deployment")) {
					$deployment ="$base\$prefix"
				}
				if (!(Test-Path "$deployment")) {
					$deployment ="$base\az"
				} 
				if (!(Test-Path $deployment)) {
					throw "deployment not found: $deployment or $base"
				}
				Write-Host "deployment:$deployment"

				Write-Host "Run tasks:$deployment\tasks.json"
				$tasks = Get-Content "$deployment\tasks.json" | ConvertFrom-Json #$steps = @("nsg","vnet","app","api","falcon-app","falcon-api","db-server","db")
				#Write-Host "tasks:$($tasks.Length)"
				Write-Host "tasks:$($tasks.tasks -join ',')"

				#if (!(Test-Path "$base\templates")) {
				#	if (!(Test-Path "$PSScriptRoot\templates")) {
				#		if (!(Test-Path "$PSScriptRoot\tests\az\templates")) {
				#			throw "\templates not found"
				#		} else { $base = "$PSScriptRoot\tests\az" }
				#	} else { $base = $PSScriptRoot}
				#}
				#Write-Host "base:$base"
				
				#if (-not (Get-Command -Name 'Install-Scripts' -ErrorAction SilentlyContinue)) {Install-Script -Name Install-Scripts -Confirm:$False -Force}
				#Install-Scripts @('Set-Tokens') #-Verbose
				if (-not (Get-Command -Name 'Set-Tokens' -ErrorAction SilentlyContinue)) {Install-Script -Name Set-Tokens -Confirm:$False -Force}
				#Write-Verbose "Set-Tokens:$base\az\$armconfig $base\$prefix\$myResourceGroupName-$armconfig"
				Set-Tokens "$deployment\templates" "$base\$prefix\$myResourceGroupName-$armconfig\templates" #-Verbose

				#if (!(Get-Module -Name Az)) { Install-Module -Name Az -AllowClobber -Confirm:$False -Force }

				if ($tasks.tasks.Length -gt 0) {
					$rsgExists = az group exists -n $myResourceGroupName
					if ($rsgExists -eq 'true') {
						#if ($Force) { #$AllowClobber) {
							#az group delete --location $location -n $myResourceGroupName
							Write-Host "Deleting:$myResourceGroupName"
							az group delete -n $myResourceGroupName --yes
							#Remove-AzResourceGroup -Name $myResourceGroupName -Force
							$rsgExists = $False
							Write-Host "Deleting:$myResourceGroupName-end"
						#} else {
						#	throw "Resource Group:$myResourceGroupName already exists - must use -Force to overwrite, todo: should be -AllowClobber"
						#}
					}
					if ($rsgExists -ne 'true') {
						#Write-Host "Creating:$myResourceGroupName"
						az group create --name $myResourceGroupName --location $location
						#Write-Host "Creating:$myResourceGroupName-end"
					}
				}
				$templatepath = "$deployment\templates"
				if (!(Test-Path $templatepath)) {
					$templatepath = "$base\az\templates"
				}
				if (!(Test-Path $templatepath)) {
					throw "templatepath not found: $templatepath or $deployment\templates"
				}
				Write-Host "templatepath:$templatepath"

				for ($i=0; $i -lt $tasks.tasks.Length; $i++) {
					$task = $tasks.tasks[$i]
					$template = $task
					
					#if ($task -eq "api") { $template = "app"}
					if (!(Test-Path "$templatepath\$template-template.json")) {
						if ($task -match '-app$' -or $task -match '-api$'){ $template = "app"}
						if (!(Test-Path "$templatepath\$template-template.json")) {
							Write-Error "File not found:$templatepath\$template-template.json"
						}
					}
					#Write-Host "test-path:$($base)/templates/$($armconfig)/$($task)-parameters.json"
					if (!(Test-Path "$base\$prefix\$myResourceGroupName-$armconfig\$task-parameters.json")) {
						Write-Error "File not found:$base\$prefix\$myResourceGroupName-$armconfig\$task-parameters.json"
					}

					#Write-Host "#az deployment group create --name $($prefix)-$($envName)-$($task) --resource-group $myResourceGroupName --template-file templates/$($template)-template.json --parameters $($config)/$($task)-parameters.json"

					#azdoEnvStatus "inProgress"
					Write-Host "Creating:$prefix-$envName-$task"
					Write-Host "az deployment group create --name $prefix-$envName-$task --resource-group $myResourceGroupName --template-file $templatepath\$template-template.json --parameters $base\$prefix\$myResourceGroupName-$armconfig\$task-parameters.json"
					try {
						az deployment group create --name "$prefix-$envName-$task" --resource-group $myResourceGroupName --template-file "$templatepath\$template-template.json" --parameters "$base\$prefix\$myResourceGroupName-$armconfig\$task-parameters.json"
						Write-Host "Created:$prefix-$envName-$task"
					}
					catch 
					{
						Write-Error "ERROR creating:$prefix-$envName-$task" -InformationVariable results
					}
					#Write-Host "Creating:$prefix-$envName-$task-end"
					#azdoEnvStatus "succeeded"
				}
			}
		}
		if ($action -eq 'help' -or !$task) {
			Write-Host '########################################' -ForegroundColor White
			Write-Host '# Tasks:' -ForegroundColor White
			#c{ Write-Host "$($_.name):$($_.value)" -ForegroundColor White }
			#($tasks.psobject.properties) | foreach-object { Write-Host "$($_.name):$($_.value)" -ForegroundColor White }
			($tasks) | foreach-object { Write-Host "$($_.name):$($_.value)" -ForegroundColor White }
			foreach($task in $tasks.Keys) {
				Write-Host "# $($task):$($tasks[$task])" -ForegroundColor White
			}
			Write-Host '########################################' -ForegroundColor White
		}
	}
}
end {
	#Set-Location $ogp

	$StopWatch.Stop()
	$StopWatch
	return $results
}