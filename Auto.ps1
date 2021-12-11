#Set-StrictMode -Version Latest
#####################################################
# Auto
#####################################################
<#PSScriptInfo

.VERSION 0.0

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
PS> .\Auto 'name'

.EXAMPLE
PS> .\Auto 'name' 'template'

.EXAMPLE
PS> .\Auto 'name' 'template' 'd:\repos'

.Link
https://github.com/Radical-Dave/Auto

.OUTPUTS
    System.String
#>
Param(
	[string] $action = "help",
	[string] $path = "",
	[switch] $Force = $false
)
$PSScriptName = ($MyInvocation.MyCommand.Name.Replace(".ps1",""))
Write-Verbose "#####################################################"
Write-Verbose "# $PSScriptName $action $path"

$StopWatch = New-Object -TypeName System.Diagnostics.Stopwatch
$StopWatch.Start()

Write-Host "$($PSScriptName):$action" -ForegroundColor White

$ogp = Get-Location
Set-Location $PSScriptRoot
if (!$path) { $path = "$($PSScriptName).json";}
Write-Host "path:$path"
if (!(Test-Path $path)) {
	throw "ERROR invalid path:$($path)"
}

try {
	#$tasks = Get-Content .\auto.json | Out-String | Invoke-Expression
	$config = (Get-Content $path -Raw) | ConvertFrom-Json
	#Write-Host "config:$($config)"
} catch {
	throw $_
}
$tasksNode = $config.psobject.properties["tasks"].value
#Write-Host "tasksNode:$($tasksNode)"
$tasks = $tasksNode.psobject.properties
#Write-Host "tasks:$($tasks)"
$taskProperty = $tasks[$action]
if ($taskProperty) {
	$task = $taskProperty.value
}
if ($task) {
	if ($task -like '.\*') {
		$path = (Join-Path $PSScriptRoot ($task.Remove(0,2)))
		Write-Host $path -ForegroundColor White
		Invoke-Expression -Command $path
	} else {
		Invoke-Expression -Command $task
	}
} elseif ($action -eq 'az') {
	Write-Host "RUN:$path"

	@((Split-Path $profile -Parent),$PSScriptRoot,("$currLocation" -ne "$PSScriptRoot" ? $currLocation : ''),(Split-Path $path -Parent)).foreach({
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

	Write-Host "Run tasks:$path"
	$tasks = Get-Content $path | ConvertFrom-Json #$steps = @("nsg","vnet","app","api","falcon-app","falcon-api","db-server","db")
	Write-Host "tasks:$tasks"

	$base = "$PSScriptRoot\tests" #(Get-Location)
	#if (!(Test-Path "$base\templates")) {
	#	if (!(Test-Path "$PSScriptRoot\templates")) {
	#		if (!(Test-Path "$PSScriptRoot\tests\az\templates")) {
	#			throw "\templates not found"
	#		} else { $base = "$PSScriptRoot\tests\az" }
	#	} else { $base = $PSScriptRoot}
	#}
	#Write-Host "base:$base"
	
	#fileTokenize "$config/*.json"
	if (-not (Get-Command -Name 'Install-Scripts')) {Install-Script -Name Install-Scripts -Confirm:$False -Force -Verbose}
	Install-Scripts @('Set-Tokens') -Verbose
	Write-Host "Set-Tokens:$base\az\$armconfig $base\$prefix\$myResourceGroupName-$armconfig"
	Set-Tokens "$base\az\$armconfig" "$base\$prefix\$myResourceGroupName-$armconfig" -Verbose

	#if (!(Get-Module -Name Az)) { Install-Module -Name Az -AllowClobber -Confirm:$False -Force }

	if ($tasks.tasks.Length -gt 0) {
		$rsgExists = az group exists -n $myResourceGroupName
		if ($rsgExists -eq 'true') {
			#if ($Force) { #$AllowClobber) {
				#az group delete --location $location -n $myResourceGroupName
				#Write-Host "Deleting:$myResourceGroupName"
				#az group delete -n $myResourceGroupName
				#Remove-AzResourceGroup -Name $myResourceGroupName -Force
				$rsgExists = $False
				#Write-Host "Deleting:$myResourceGroupName-end"
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
	$aztemplates = "az\templates"
	for ($i=0; $i -lt $tasks.tasks.Length; $i++) {
		$task = $tasks.tasks[$i]
		$template = $task
		
		#if ($task -eq "api") { $template = "app"}
		if (!(Test-Path "$base\$aztemplates\$template-template.json")) {
			if ($task -match '-app$' -or $task -match '-api$'){ $template = "app"}
			if (!(Test-Path "$base\$aztemplates\$template-template.json")) {
				Write-Error "File not found:$base\$aztemplates\$template-template.json"
			}
		}
		#Write-Host "test-path:$($base)/templates/$($armconfig)/$($task)-parameters.json"
		if (!(Test-Path "$base\$prefix\$myResourceGroupName-$armconfig\$task-parameters.json")) {
			Write-Error "File not found:$base\$prefix\$myResourceGroupName-$armconfig\$task-parameters.json"
		}

		#Write-Host "#az deployment group create --name $($prefix)-$($envName)-$($task) --resource-group $myResourceGroupName --template-file templates/$($template)-template.json --parameters $($config)/$($task)-parameters.json"

		#azdoEnvStatus "inProgress"
		Write-Host "Creating:$prefix-$envName-$task"
		#Write-Host "az deployment group create --name $prefix-$envName-$task --resource-group $myResourceGroupName --template-file $base\$aztemplates\$template-template.json --parameters $base\$prefix\$myResourceGroupName-$armconfig\$task-parameters.json"
		try {
			az deployment group create --name "$prefix-$envName-$task" --resource-group $myResourceGroupName --template-file "$base\$aztemplates\$template-template.json" --parameters "$base\$prefix\$myResourceGroupName-$armconfig\$task-parameters.json"
		}
		catch 
		{
			Write-Error "ERROR creating:$prefix-$envName-$task" -InformationVariable results
		}
		#Write-Host "Creating:$prefix-$envName-$task-end"
		#azdoEnvStatus "succeeded"
	}
} elseif ($action -ne 'help') {
	Write-Host "Task not found in $PSScriptName.json: $action" -ForegroundColor White
}

if ($action -eq 'help' -or !$task) {
	Write-Host '########################################' -ForegroundColor White
	Write-Host 'Tasks:' -ForegroundColor White
	#c{ Write-Host "$($_.name):$($_.value)" -ForegroundColor White }
	#($tasks.psobject.properties) | foreach-object { Write-Host "$($_.name):$($_.value)" -ForegroundColor White }
	($tasks) | foreach-object { Write-Host "$($_.name):$($_.value)" -ForegroundColor White }
	foreach($task in $tasks.Keys) {
		Write-Host "$($task):$($tasks[$task])" -ForegroundColor White
	}
	Write-Host '########################################' -ForegroundColor White
}

Set-Location $ogp

$StopWatch.Stop()
$StopWatch