#Set-StrictMode -Version Latest
#####################################################
# Auto
#####################################################
<#PSScriptInfo

.VERSION 0.23

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
- see README.md

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
	[string] $action = 'help',
	[Parameter(Mandatory = $false, Position=1)]
	[string] $data = '',
	[Parameter(Mandatory = $false, Position=2)]
	[string] $path = '',
	[string] $adApp = 'DevOps',
	[switch] $Force = $false,
	[switch] $recurse = $false
)
begin {
	$Global:ErrorActionPreference = 'Stop'
	$PSScriptName = ($MyInvocation.MyCommand.Name.Replace(".ps1",""))
	$PSScriptVersion = (Test-ScriptFileInfo -Path $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty Version)
	$PSCallingScript = if ($MyInvocation.PSCommandPath) { $MyInvocation.PSCommandPath | Split-Path -Parent } else { $null }
	Write-Verbose "#####################################################"
	Write-Host "# $PSScriptRoot/$PSScriptName $($PSScriptVersion):$action $data $path called by:$PSCallingScript" -ForegroundColor White
	
	$StopWatch = New-Object -TypeName System.Diagnostics.Stopwatch
	$StopWatch.Start()
	Write-Verbose "path:$path"

	if (@('az','tf') -contains $action -and $data -ne "") {
		if (Test-Path "$PSScriptRoot\data\$action\$data\tasks\$data.json") {
			$path = "$PSScriptRoot\data\$action\tasks.json";
		} elseif (Test-Path "$PSScriptPath\data\$action\tasks\$data\$data.json") {
			$path = "$PSScriptPath\data\$action\$data\tasks.json";
		}
		$tasks = $path
	} else {
		if (!$path -and $action -ne 'az') {
			if (Test-Path "$PSScriptRoot/$PSScriptName.json") {
				$path = "$PSScriptRoot/$PSScriptName.json"
			} else {
				$profileParent =Split-Path $profile -Parent
				if (Test-Path "$profileParent/$($PSScriptName).json") {
					$path = "$profileParent/$($PSScriptName).json"
				}
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
			$configFile = (Get-Content $path -Raw) | ConvertFrom-Json
			#Write-Host "config:$($config)"
		} catch {
			throw $_
		}
		Write-Verbose "logs:$($configFile.logs)"
		try {
			#Write-Verbose "checking tasks"
			$tasksNode = $configFile.psobject.properties["tasks"].value
			#Write-Verbose "checking props"
			#Write-Host "tasksNode:$($tasksNode)"
			$tasks = $tasksNode.PSObject.Properties
			#Write-Host "tasks:$($tasks)"
		} catch {
			Write-Verbose "NON-Critical? Error parsing task(s): $_"
		}
	}
	
	if (!$path) {
		if ((Test-Path "$PSScriptPath\data\$action\$data\tasks.json")) {
			$path = "$PSScriptPath\data\$action\$data\tasks.json";
		}
	}

	Write-Verbose "path:$path"
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
			$configFile.tasks | Add-Member -MemberType NoteProperty -Name "$($ds[0])" -Value "$($ds[1])" -PassThru -Force
		#}
		$configFile | ConvertTo-Json | Out-File $path
	} elseif ($action -eq 'del' -or $action -eq 'delete' -and $data) {
		if (!$configFile -or !$configFile.tasks) {
			throw 'ERROR no config or config.tasks?'
		}
		Write-Host "delete task:$data"
		$configFile.tasks.PSObject.Properties.Remove("$data")
		$configFile | ConvertTo-Json | Out-File $path
	} else {
		$task = @()
		Write-Verbose "action:$action"
		if ($tasks -and $action -ne 'help') {
			$taskProperty = $tasks[$action]
			Write-Verbose "taskProperty:$taskProperty"
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
			if ($PSBoundParameters.ContainsKey('recurse')) {
				$filter = @('terraform') -contains $data ? "*.*" : "*.tf"
				#if (@('terraform') -contains $data) { $filter = "*.tf"
				Write-Host "action:$action"
				Write-Host "data:$data"
				Write-Host "filter:$filter"
				$cwd = $PWD
				#Get-ChildItem $data -recurse -exclude ".*" -include $filter | Foreach-Object {
				#Get-ChildItem $data -Directory -recurse -exclude ".*" -include $filter | Foreach-Object {
				#Get-ChildItem $data -recurse -exclude ".*" -include $filter | Select-Object Directory -Unique | Foreach-Object {	
				$folders = Get-ChildItem -exclude ".*" -Path $data -Recurse | Where-Object {$_.PSIsContainer}# | ForEach-Object {
				foreach($folder in $folders) {
					if (Test-Path "$folder\$filter") {
						Write-Host "### X:$folder"
						Set-Location $folder -verbose
						#Write-Host "### Set:${$_}"
						#Write-Host "### Set:${$_.FullName}"
						Invoke-Expression -Command $action -OutVariable $results
					}
				}
				Write-Host "stop"
				Set-Location $cwd
				exit
			}
			#if ($action -ne 'help' -and $action -ne 'az' -and $action -ne 'tf') {
			if (@('help','az','tf','tfd','sql') -notcontains $action) {
				Write-Host "!#$! Task not found in $PSScriptName.json: $action, to add use: -addTask 'AutoScript'" -ForegroundColor White
			}
			if ($action -eq 'sql') {
				if(!$data) {$data = 'SELECT @@version'} #* FROM SYS.DATABASES #SYS_TABLES

				if ($path -notlike ';') {
					#use config
					$path = "Data Source=(local);Initial Catalog=.;Integrated Security=SSPI;"
				}

				Write-Host "RUN:$data"
				Write-Host "AGAINST:$path"
				
				Write-Host "path:$path"
				try {
					$connection = New-Object system.data.sqlclient.sqlconnection		
					Write-Verbose "[BEGIN  ] Creating the SQL Command object"
					$cmd = New-Object system.Data.SqlClient.SqlCommand
					$connection.connectionstring = $path
					$connection.open()

					#join the connection to the command object
					$cmd.connection = $connection
					$cmd.CommandText = $data
					
					Write-Verbose "[PROCESS] Invoking $data"
					if ($PSCmdlet.ShouldProcess($data)) {
						
						#determine what method to invoke based on the query
						Switch -regex ($data) {
							"^Select (\w+|\*)|(@@\w+ AS)" {							
								$reader = $cmd.executereader()
								$out=@()
								#convert datarows to a custom object
								while ($reader.read()) {									
									$h = [ordered]@{}
									for ($i=0;$i -lt $reader.FieldCount;$i++) {
										$col = $reader.getname($i)											
										$h.add($col,$reader.getvalue($i))
									} #for
									$out += new-object -TypeName psobject -Property $h 
								} #while

								$out
								$reader.close()
								Break
							}
							"@@" { 
								$cmd.ExecuteScalar()
								Break
							}
							Default {
								$cmd.ExecuteNonQuery() | Out-Null
							}
						}
					}
				} 
				catch {
					throw "ERROR $PSScriptName sql $data - $_" #-InformationVariable results
				}
			} elseif (@('az','tf','tfd') -contains $action) {
				Write-Host "RUN:$path"

				$envPrefix = ''
				#if ($action -eq 'tf') { $envPrefix = 'TF_VAR_'}
				if (@('tf','tfd') -contains $action) { $envPrefix = 'TF_VAR_'}
				
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
										Write-Verbose "reading setting from:$($f.FullName)"
										$content = (Get-Content $f.FullName)
										$content | ForEach-Object {
											if (-not ($_ -like '#*') -and  ($_ -like '*=*')) {
												$sp = $_.Split('=')
												#Write-Host "Set-Env $($sp[0])=$($sp[1])"
												[System.Environment]::SetEnvironmentVariable("$envPrefix$sp[0]", $sp[1])
												if (@('envName','location','prefix') -contains $sp[0]) { 
													[System.Environment]::SetEnvironmentVariable("$sp[0]", $sp[1])
													#$env[$sp[0]] = $sp[1] #Write-Error?
													switch ($sp[0]) {
														'envName' {$envName = $sp[1]}
														'location' {$location = $sp[1]}
														'prefix' {$prefix = $sp[1]}
													}
													Write-Host "Set-Env $($sp[0])=$($sp[1])"
												}
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
				if (!$prefix) { $prefix = 'smoke' }
				Write-Host "prefix:$($prefix)"

				if (!$envName) { $envName = $env:envName }
				if (!$envName) { $envName = $env:RELEASE_ENVIRONMENTNAME}
				if (!$envName) { $envName = 'test'}
				Write-Host "envName:$($envName)"

				if (!$location) { $location = $env:location }
				if (!$location) {$location = 'eastus'}
				Write-Host "location:$($location)"

				if (!$template) { $template = 'default'}

				$resourceGroupName="$prefix-$envName"
				Write-Host "deploying:$($resourceGroupName)"

				#az group create --name $resourceGroupName --location $location
				
				Write-Host "data:$($data)"
				Write-Verbose "checking:$data"
				#Write-Verbose "checking:$data/env/$prefix/$prefix-$envName-$template-$action"
				#if ($data -and (Test-Path "$data/$prefix-$envName-$template-$action")) {
				#	$base = Split-Path $data -Parent
				#	#$base = $data
				#	Write-Host "base1:$($base)"
				#} else
				if ($data -and (Test-Path "$data")) {
					$parent = Get-Item(Split-Path (Get-Item $data) -Parent)
					if ($parent.Name -eq 'tasks') {
						$base = Split-Path (Get-Item $parent) -Parent
						Write-Host "parent.base:$($base)"
					} else {
						Write-Host "parent.base:$($parent.Name)"
					}
				} elseif (Test-Path "$data\$action\templates\$task") {
					Write-Host "task.base:$($base)"
					$base = $data
				} else {
					$base = "$(Get-Location)\data"
					Get-ChildItem
					Write-Host "testing.base:$($base)"
					if (!(Test-Path $base)) {
						$base = "$PSScriptRoot\data"
						Write-Host "final.base:$($base)"
					}
				}
				if (!(Test-Path $base)) {
					throw "data not found:$base"
				}
				Write-Host "base:$base"

				$taskname = "tasks"
				$taskpath = $path
				if (!$taskpath) {				
					#todo:test-paths, az is always base, but checking for customs
					#$taskpath = "$base\tasks\$prefix-$envName-$template-$action"
					$providerbase = "$base\providers\$action"
					Write-Host "providerbase:$providerbase"
					$taskpath = "$providerbase\tasks\$prefix-$envName-$template-$action"
					if (!(Test-Path "$taskpath\tasks.json")) {
						$taskpath ="$providerbase\tasks\$prefix-$envName-$template"
					}
					if (!(Test-Path "$taskpath\tasks.json")) {
						$taskpath ="$providerbase\tasks\$prefix-$envName"
					}
					if (!(Test-Path "$taskpath\tasks.json")) {
						$taskpath ="$providerbase\tasks\$prefix"
					}
					if (!(Test-Path "$taskpath\tasks.json")) {
						$taskpath ="$providerbase\tasks\$prefix"
					}
					if (!(Test-Path "$taskpath\tasks.json")) {
						$taskpath ="$providerbase\tasks\$action"
					} 
					if (!(Test-Path "$taskpath\tasks.json")) {
						$taskpath ="$providerbase\tasks"
					}
					Write-Host "taskpath:$taskpath"
					if (!(Test-Path $taskpath)) {
						throw "taskpath not found: $taskpath or $providerbase"
					}
					if ($taskpath.EndsWith(".json")) {
						$taskname = $data
						Write-Verbose "taskname:$taskname"
					}
				}
				Write-Verbose "taskpath:$taskpath"

				# ServicePrincipal - moved below?
				
				#Write-Host "Run tasks:$taskpath\$taskname.json"
				#$tasks = Get-Content "$taskpath\$taskname.json" | ConvertFrom-Json #$steps = @("nsg","vnet","app","api","falcon-app","falcon-api","db-server","db")
				#Write-Host "tasks:$($tasks.Length)"
				if (Test-Path "$taskpath\$taskname.json") {
					try {
						$tasks = Get-Content "$taskpath\$taskname.json" | ConvertFrom-Json #$steps = @("nsg","vnet","app","api","falcon-app","falcon-api","db-server","db")
						Write-Host "tasks:$($tasks.tasks -join ',')"
					} catch {
						Write-Verbose "FILE DOES NOT EXIST:$taskpath\$taskname.json:$_" -InformationVariable results
					}
				}

				#if (!(Test-Path "$base\templates")) {
				#	if (!(Test-Path "$PSScriptRoot\templates")) {
				#		if (!(Test-Path "$PSScriptRoot\tests\az\templates")) {
				#			throw "\templates not found"
				#		} else { $base = "$PSScriptRoot\tests\az" }
				#	} else { $base = $PSScriptRoot}
				#}
				#Write-Host "base:$base"
				
				$varspath = ''
				if(!$varspath) {
					Write-Host "Checking:$base\providers\$action\vars\$template"
					if (Test-Path "$base\providers\$action\vars\$template") {
						$varspath = "$base\providers\$action\vars\$template"
					} else { $varspath = "$base\providers\tf"}
				
					if (!(Test-Path "$varspath")) { #\$template")) {
						throw "varspath not found: $varspath or $base"
					}
				}
				Write-Host "varspath:$varspath"
				#Write-Host "Expand-Token start"
				#if (-not (Get-Command -Name 'Install-Scripts' -ErrorAction SilentlyContinue)) {Install-Script -Name Install-Scripts -Confirm:$False -Force}
				#Install-Scripts @('Set-Tokens') #-Verbose
				
				if (-not (Get-Command -Name 'Expand-Token' -ErrorAction SilentlyContinue)) {Install-Script -Name 'Expand-Token' -Confirm:$False -Force}

				if ($action -eq 'az') {					
					Write-Host "Calling Expand-Token:$varspath $base\env\$prefix\$resourceGroupName-$template-$action"
					if ($VerbosePreference -eq [System.Management.Automation.ActionPreference]::SilentlyContinue) {
						Expand-Token "$varspath" "$base\env\$prefix\$resourceGroupName-$template-$action" -Verbose
					} else {
						#Write-Host "Verbose"
						Expand-Token "$varspath" "$base\env\$prefix\$resourceGroupName-$template-$action" -Verbose
					}
					Write-Host "Expand-Token done:$base\env\$prefix\$resourceGroupName-$template-$action"
				}
				

				#if (!(Get-Module -Name Az)) { Install-Module -Name Az -AllowClobber -Confirm:$False -Force }


				#Write-Host "tasks:$tasks"
				#if (!$tasks) {$tasks.tasks = 'main'}

				if ($tasks.tasks.Length -gt 0) {
					cmd /c "az account show" '2>&1' | Tee-Object -Variable jsonResults
					#Write-Host "jsonResults:$jsonResults"
					#if ($null -ne ($jsonResults | Where-Object { $_ -match 'expired'})) {
					#if ($jsonResults -like '*error*' -or $jsonResults -clike '*expired*') {
					if ($jsonResults -like '*error*') {
						Write-Host "Need to sign in"
						#Write-Host "NOW WE CAN ATTACK! $PSScriptName ERROR:$jsonResults"

						#$sp = New-AzADServicePrincipal -DisplayName ServicePrincipalName
						#$sp.PasswordCredentials.SecretText
						#$pscredential = Get-Credential -UserName $sp.AppId

						$devOpsU = [Environment]::GetEnvironmentVariable("$($adApp)_user")
						Write-Host "devOpsU:$devOpsU"
						$devOpsP = [Environment]::GetEnvironmentVariable("$($adApp)_pwd")
						Write-Host "devOpsP:$devOpsP"
						if ($devOpsU -and $devOpsP) { 
							az login -u $devOpsU -p $devOpsP 
						} else {
							throw "$PSScriptName ERROR - unable to login: $jsonResults"
						}
					}				
					cmd /c "az group exists -n $resourceGroupName" '2>&1' | Tee-Object -Variable jsonResults
					Write-Host "****"
					Write-Host "jsonResults:$jsonResults"
					Write-Host "****"
					#if ($null -ne ($jsonResults | Where-Object { $_ -match 'error'})) {
					if ($jsonResults -like '*error*') {	
							Write-Host "****"								
						#if ($null -ne ($jsonResults | Where-Object { $_ -match 'expired'})){
							if ($jsonResults -like '*expired*') {
								Write-Host "****"
							$devOpsU = [Environment]::GetEnvironmentVariable("$($adApp)_user")
							Write-Host "devOpsU:$devOpsU"
							$devOpsP = [Environment]::GetEnvironmentVariable("$($adApp)_pwd")
							Write-Host "devOpsP:$devOpsP"
							if ($devOpsU -and $devOpsP) {
								az login -u $devOpsU -p $devOpsP
							} else {
								throw "$PSScriptName ERROR - unable to login: $jsonResults"
							}
						}
						throw "$PSScriptName ERROR checking for ${resourceGroupName}: $jsonResults"
					}
					Write-Host "rgExists:$rgExists"
					if ((@('az','azd') -contains $action) -and $rgExists -eq 'true' -and $clobber ) {
						#if ($Force) { #$AllowClobber) {
							#az group delete --location $location -n $resourceGroupName
							Write-Host "Deleting:$resourceGroupName - because it already exists!?!"
							az group delete -n $resourceGroupName --yes
							#Remove-AzResourceGroup -Name $resourceGroupName -Force
							$rgExists = $False
							Write-Host "Deleting:$resourceGroupName-end"
							if ($action -eq 'az') {return}
						#} else {
						#	throw "Resource Group:$resourceGroupName already exists - must use -Force to overwrite, todo: should be -AllowClobber"
						#}
					}
					if ($rgExists -ne 'true' -and $action -eq 'az') {
						#Write-Host "Creating:$resourceGroupName"
						az group create --name $resourceGroupName --location $location
						#Write-Host "Creating:$resourceGroupName-end"
					}
				}
				if ($action -eq 'tfsetup') {
					#$tfContainerName = "base-terraform.exe" #"$resourceGroupName-terraform.exe"
					$tfContainerName = "tfstate"
					$tfstorageAccountName = "projectbasesa" #$tfContainerName.Replace("-","") + 'sa'
					$brgName = "base" #"$tfContainerName-rg"
					$tfKeyVaultName = "projectbase-kv" #"$tfContainerName-kv"
					$tfKeyVaultSecret = "$resourceGroupName-terraform.tfstate"					
					Write-Host "tfstorageAccountName:$tfstorageAccountName"

					#$brgExists = $False
					#cmd /c "az group exists -n $brgName" '2>&1' | Tee-Object -Variable jsonResults
					$brgExists = "${$(az group exists -n $brgName)}" -eq "true"
					#$brgExists = $(az group exists -n $brgName) -eq "true"
					# if ($null -ne ($jsonResults | Where-Object { $_ -match 'error'})) {
					# 	#throw "$PSScriptName ERROR checking for ${brgName}: $jsonResults"
					# 	Write-Host "ResourceGroup not found - creating: $brgName"
					# } else {
					# 	$brgExists = $True
					# }

					#core-azure-devops
					#
					#az group create --name core-azure-devops --location centralus
					#az deployment group create --name "ProjectName" --resource-group "core-azure-devops" --template-file "data\providers\az\templates\azdo-org.json" --parameters "data\providers\az\default\azdo-org-paramters.json"


					Write-Host "brgExists:$brgExists"
					if (!$brgExists) {
						az group create --name $brgName --location $location
						az storage account create --resource-group $brgName --name $tfstorageAccountName --sku Standard_LRS --encryption-services blob
						$tfAccountKey = $(az storage account keys list --resource-group $brgName --account-name $tfstorageAccountName --query [0].value -o tsv)
						if ($null -eq $tfAccountKey) {
							throw "$PSScriptName ERROR checking for sp ${tfAccountKey}"
						}
						Write-Host "${tfstorageAccountName}:$tfAccountKey"
					}

					$kvExists = $False
					cmd /c "az keyvault list" '2>&1' | Tee-Object -Variable jsonResults #throws error if you pass keyvalue name!
					if ($null -ne ($jsonResults | Where-Object { $_ -match 'error'}) -or ($null -eq ($jsonResults | Where-Object { $_ -match $tfKeyVaultName}))) {
						#throw "$PSScriptName ERROR checking for ${tfKeyVaultName}: $jsonResults"
						Write-Host "KeyVault not found - creating: $tfKeyVaultName"
					} else {
						$kvExists = $True
					}
					if (!$kvExists) {
						az keyvault create --name $tfKeyVaultName --resource-group $brgName --location $location
						az keyvault secret set --name $tfKeyVaultSecret --vault-name $tfKeyVaultName --value $tfAccountKey
					}
					az storage container create --name $tfContainerName --account-name $tfstorageAccountName --account-key $tfAccountKey

					#$var = (Get-Content .\$file -Raw | ConvertFrom-StringData)
					#$template -f $var.var1, $var.var2, $var.var3


					$subscriptionId = ''
					$spName = 'azdevops'
					$spId = ''
					$spKey = ''
					$uservarpath = ''
					$adApp = ''
					if (Test-Path -Path ".env.user") {$uservarpath = ".env.user"}
					if (!$uservarpath -and (Test-Path "$varspath\$data.tfvars")) {$uservarpath = "$varspath\$data.tfvars";}
					if (!$uservarpath -and (Test-Path "$taskpath\.tfvars")) {$uservarpath = "$taskpath\.tfvars";}
					Write-Host "uservarpath:$uservarpath"
					if ($uservarpath -and (Test-Path $uservarpath)) {
						$tfvars = Get-Content -Raw -Path $uservarpath | ConvertFrom-StringData
						if($tfvars.ad_app -and $tfvars.ad_app -ne $adApp) { $adApp = $tfvars.ad_app }
						if($tfvars.client_name -and $tfvars.client_name -ne $spName) { $spName = $tfvars.client_name }
						if($tfvars.subscription_id -and $tfvars.subscription_id -ne $subscriptionId) { $subscriptionId = $tfvars.subscription_id }
						if($tfvars.client_id -and $tfvars.client_id -ne $spId) {$spId = $tfvars.client_id }
						if($tfvars.client_secret -and $tfvars.client_secret -ne $spKey) {$spKey = $tfvars.client_secret }
					}
					if ($null -eq $subscriptionId) {
						$azinfo = $(az account show)
						if ($azinfo) { $subscriptionId = $azinfo.id;}
					}
					if ($null -eq $subscriptionId) {
						throw "$PSScriptName ERROR no subscriptionId"
					}

					#Write-Host "spId:$($spId)"
					#Write-Host "spKey:$($spKey)"

					if (!$spId -or !$spKey) {
						$spKv = $(az keyvault secret show --name $spName --vault-name $tfKeyVaultName) | ConvertFrom-Json
						if ($spKv) {
							$spId = $spKv.id;
							$spKey = $spKv.value;
							#Write-Host 'Retrieved from keyvault!'
						}
					}
					
					$appId = ''
					if ($adApp -ne '') {
						$appId=$(az ad app list --display-name $adApp --query [].appId -o tsv)
						Write-Host "appId:$($appId)"
						#$app = $(az ad app list --display-name $adApp) | ConvertFrom-Json
						#if ($app -eq '[]') { $app = ''}
						if (!$appId) {
							Write-Host "Creating adApp:$adApp"
							az ad app create --display-name $adApp
							$app = $(az ad app list --display-name $adApp)
							$appId = $app.id
						} else { 
							#Write-Host "App found:$adApp-$($appId)"
							Write-Host "App found:$($app)"
						}
						#Write-Host "app.id: $($appId)"
						$spId = $(az ad sp list --display-name $adApp --query "[].appId" -o tsv)
						#Write-Host "spId: $spId"
					}

					if ($spId) {							
						#if ($spId -ne $null -and $spKey -eq $null) { $spKey = $(az storage account keys list --resource-group $brgName --account-name $tfstorageAccountName --query [0].value -o tsv)}
						#$spId = client_id
						$spIdExists = $(az ad sp show --id $spId --output tsv | Where-Object { $_ -match '$spId'})
						#Write-Host "spIdExists:$spIdExists"
						if(!$spIdExists) {
							$results = $(az ad sp create-for-rbac --name $spName --role Contributor --scope "/subscriptions/$subscriptionId") | ConvertFrom-Json
							#Write-Host "results: $results"
							$spKey = $results.password
							#Write-Host "storing: $spKey"
							if ($spKey) {
								#Write-Host 'in keyvault'
								az keyvault secret set --name $spName --vault-name $tfKeyVaultName --value $spKey
							}						
						}
					}

					Write-Host "spId: $spId"
					Write-Host "spKey: $spKey"

					if ($data -eq 'setup') {

						

						Write-Host 'setup complete.'
						return;
					}

					$tfAccountKey = $(az storage account keys list --resource-group $brgName --account-name $tfstorageAccountName --query [0].value -o tsv)
					if ($null -eq $tfAccountKey) {
						throw "$PSScriptName ERROR checking for sp ${tfAccountKey}"
					}
					Write-Host "${tfstorageAccountName}:$tfAccountKey"
				}
				#$templatepath = Join-Path (Split-Path $varspath -Parent) "templates"
				$templatepath = "$base/providers/$action/templates"
				Write-Host "Checking:$templatepath"
				if (!(Test-Path $templatepath)) {
					$templatepath = "$base\$action\templates"
				}
				if (!(Test-Path $templatepath)) {
					throw "templatepath not found: $templatepath or $path\templates"
				}
				Write-Host "templatepath:$templatepath"

				if ($tasks.tasks.Length -eq 0) {
					#$tasks.tasks = @("main")
					$tasks = '{"tasks":["main"]}' | ConvertFrom-Json
				}
				for ($i=0; $i -lt $tasks.tasks.Length; $i++) {
					$task = $tasks.tasks[$i]
					$template = $task
					
					if ($action -eq 'az') {
						#if ($task -eq "api") { $template = "app"}
						if (!(Test-Path "$templatepath\$template-template.json")) {
							if ($task -match '-app$' -or $task -match '-api$'){ $template = "app"}
							if (!(Test-Path "$templatepath\$template-template.json")) {
								Write-Error "File not found:$templatepath\$template-template.json"
							}
						}
						#Write-Host "test-path:$($base)/templates/$($config)/$($task)-parameters.json"
						if (!(Test-Path "$base\env\$prefix\$resourceGroupName-$template\$task-parameters.json")) {
							Write-Error "File not found:$base\env\$prefix\$resourceGroupName-$template\$task-parameters.json"
						}
					}

					#azdoEnvStatus "inProgress"
					Write-Host "Running:$prefix-$envName-$task"
											
					try {
						if ($action -eq 'az') {
							Write-Host "az deployment group create --name $prefix-$envName-$task --resource-group $resourceGroupName --template-file $templatepath\$template-template.json --parameters $base\env\$prefix\$resourceGroupName-$template\$task-parameters.json"
							az deployment group create --name "$prefix-$envName-$task" --resource-group $resourceGroupName --template-file "$templatepath\$template-template.json" --parameters "$base\env\$prefix\$resourceGroupName-$template\$task-parameters.json"
						} elseif (@('tf','tfd') -contains $action) {
							$workingDirectory = "$base\providers\$action\tasks\$data" #"$templatepath\plans\$template"
							Write-Host "Set working directory:$workingDirectory"
							$origLocation = Get-Location
							if ($origLocation -ne $workingDirectory) { 
								Set-Location $workingDirectory
								Write-Host "Executing terraform.exe init:$workingDirectory"
								terraform.exe init
								#terraform.exe init -backend-config="storage_account_name=<YourAzureStorageAccountName>" -backend-config="container_name=tfstate" -backend-config="access_key=<YourStorageAccountAccessKey>" -backend-config="key=codelab.microsoft.tfstate"
							}

							Write-Host "Checking for vars"
							#$varFile = "$base\providers\$prefix\vars\$resourceGroupName-$template-$action"
							#$varFile = "$base\env\$prefix\vars\$template"
							$varFile = "$base\providers\$action\vars\$template\$template.tfvars"
							$varFileTokens = "$base\env\$prefix\$resourceGroupName-$template-$action"
							#$varFile = "$base\env\$prefix\$resourceGroupName-$template-$action"
							Write-Host "Generating tfplan: $prefix-$envName-$task.tfplan"
							if (Test-Path $varFile) {
								Write-Host "Using:$varFile"
								if (!(Test-Path "$base\env\$prefix\$resourceGroupName-$template-$action")) { New-Item "$base\$prefix\$resourceGroupName-$template-$action" -ItemType Directory | Out-Null}
								$varFileTokens = "$base\env\$prefix\$resourceGroupName-$template-$action\$template.tfvars"
								Expand-Token "$varFile" "$varFileTokens"
								#Set-Location $workingDirectory
								Write-Host "CurrentLocation:$(Get-Location)"
								Write-Host "varFileTokens:$varFileTokens"
								#terraform.exe apply -var-file="$varFileTokens" -out="$prefix-$envName-$task.tfplan" -input=false
								if ($action -eq 'tf') {
									terraform.exe plan -var-file="$varFileTokens" -out="$prefix-$envName-$task.tfplan" -input=false
								} else {
									terraform.exe plan -var-file="$varFileTokens" -destroy -out="$prefix-$envName-$task.tfplan" -input=false
								}
								#terraform.exe apply "$prefix-$envName-$task.tfplan" -var-file="$varFileTokens"
							} else {
								if ($action -eq 'tf') {
									terraform.exe plan -out="$prefix-$envName-$task.tfplan"
								} else {
									terraform.exe plan -destroy -out="$prefix-$envName-$task.tfplan"
								}

							}
							Write-Host "Applying terraform.exe plan:$prefix-$envName-$task.tfplan"
							if ($action -eq 'tf') {
								terraform.exe apply "$prefix-$envName-$task.tfplan"
							} else {
								terraform.exe -destroy apply "$prefix-$envName-$task.tfplan"
							}
							if ((Get-Location) -ne $origLocation) { Set-Location $origLocation}
						}
						Write-Host "Created:$prefix-$envName-$task"
					}
					catch 
					{
						Write-Error "ERROR creating:$prefix-$envName-$($task):$_" -InformationVariable results
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