<#PSScriptInfo

.VERSION 0.1

.GUID e7172940-4e12-425e-9e65-c7ab1b2ffc1f

.AUTHOR David Walker, Sitecore Dave, Radical Dave

.COMPANYNAME David Walker, Sitecore Dave, Radical Dave

.COPYRIGHT David Walker, Sitecore Dave, Radical Dave

.TAGS powershell script

.LICENSEURI https://github.com/Radical-Dave/Template-Script/blob/main/LICENSE

.PROJECTURI https://github.com/Radical-Dave/Template-Script

.ICONURI

.EXTERNALMODULEDEPENDENCIES

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES


#>

<#
.SYNOPSIS
@@synoposis@@

.DESCRIPTION
@@description@@

.EXAMPLE
PS> .\Template-Script 'name'

.Link
https://github.com/Radical-Dave/Template-Script

.OUTPUTS
    System.String
#>
#####################################################
#  Template-Script
#####################################################
[CmdletBinding(SupportsShouldProcess,PositionalBinding=$false)]
Param(
	# Name of new script
	[Parameter(Mandatory=$false, Position=0)] [string]$name,
    # Description of script [default - from template]
	[Parameter(Mandatory=$false)] [string]$description = "",
    # Name of template to use [default - template] - uses -PersisForCurrentUser
	[Parameter(Mandatory=$false)] [string]$template = "",
    # Author of script [default - from template] - uses -PersisForCurrentUser
	[Parameter(Mandatory=$false)] [string]$author = "",
    # Repos path - uses PersistForCurrentUser so it can run from anywhere, otherwise current working directory
	[Parameter(Mandatory=$false)] [string]$repos = "",
    # Script content for new Script
	[Parameter(Mandatory=$false)] [string]$script = "",
	# Save repos path to env var for user
	[Parameter(Mandatory=$false)] [switch]$PersistForCurrentUser = $true,
    # Force - overwrite if index already exists
    [Parameter(Mandatory=$false)] [switch]$Force = $false
)
begin {
	$ErrorActionPreference = 'Stop'
    Write-Verbose "PSHome:$PSHome"
	$PSScriptName = $MyInvocation.MyCommand.Name.Replace(".ps1","")
    $PSScriptPath = $MyInvocation.MyCommand.Path
    $PSScriptAuthor = "$(Get-Content $PSScriptPath | Where-Object {$_ -like ‘.AUTHOR*’})".Remove(0, 8)
    $PSScriptFolder = Split-Path $PSScriptPath -Parent
    $ReposFolder = Split-Path $PSScriptFolder -Parent
    if (!$name) { $name = "$PSScriptName-Test" }
	$PSCallingScript = if ($MyInvocation.PSCommandPath) { $MyInvocation.PSCommandPath | Split-Path -Parent } else { $null }
    if ($PSCallingScript) { Write-Verbose "PSCallingScript:$PSCallingScript"}
	Write-Verbose "$PSScriptName $name $template"

    $scope = "User" # Machine, Process
    $eKey = "cs"
    $rKey = "repos"
    $tKey = "template"
    $aKey = "author"

    #todo: if (!$repos) { $repos = Get-Env("$eKey-$aKey", $scope, Get-Location)
    #todo: if (($repos | Split-Path -Leaf) -eq $PSScriptName) { $repos = Split-Path $repos -Parent}
	if (!$repos) { # is there some git cmd/setting we can use?
		$repos = [Environment]::GetEnvironmentVariable("$eKey-$rKey", $scope)
		if (!$repos) {
			$repos = Get-Location
            if (($repos | Split-Path -Leaf) -eq $PSScriptName) { $repos = Split-Path $repos -Parent}
		}
	}
    Write-Verbose "repos:$repos"
    $path = Join-Path $repos $name
    Write-Verbose "path:$path"

    #todo: if (!$template) { $template = Get-Env("$eKey-$tKey", $scope, $PSScriptName)
    if (!$template) { 
        $template = [Environment]::GetEnvironmentVariable("$eKey-$tKey",$scope)
        if (!$template) { $template = $PSScriptName } 
    }
    #if (!$template) { # is there some git cmd/setting we can use?
	#	$template = [Environment]::GetEnvironmentVariable("$eKey-$tKey", $scope)
    #    Write-Verbose "template persisted using -PersistForCurrentUser:$template"
	#	if (!$template) {
	#		$template = $PSScriptName
	#	}
	#}
    Write-Verbose "template:$template"

    $templatePath = Join-Path $repos $template
    Write-Verbose "templatePath:$templatePath"
    $templateScriptPath = Join-Path $templatePath "$template.ps1"
    Write-Verbose "templateScriptPath:$templateScriptPath"
    if (Test-Path $templateScriptPath) {
        #$script = Get-Content $templateScriptPath
        #Write-Verbose "script:$script"
    }

    #todo: if (!$author) { $author = Get-Env("$eKey-$aKey", $scope, $env:USERNAME)
    # is there some git cmd/setting we can use?
    if (!$author) { $author = [Environment]::GetEnvironmentVariable("$eKey-$aKey", $scope) }
    if (!$author) { $author = "$(Get-Content $templateScriptPath | Where-Object {$_ -like ‘.AUTHOR*’})".Remove(0, 8) }
    if (!$author) { $author = $env:USERNAME }
    Write-Verbose "author:$author"

    if (!$description) { $description = "$name PowerShell Script"}

    if ($template = $PSScriptName) {
        Write-Verbose "templateAuthor:$templateAuthor"
        $content = $content.Replace("Template-Script", $name)
        $content = $content.Replace("beae9bf9-f016-416e-8443-d756a8799ff9", "$(New-Guid)")
        
        
        $content = $content.Replace($templateAuthor, $author)
        $content = $content.Replace("Create PowerShell Script in folder [Name]/[Name].ps1 based on template", $description)
        $content = $content.Replace("Template and Repos (aka Destination path) can be persisted using -PersistForCurrentUser", "")
    } else {
        $content = $content.Replace($template, $name)
        $content = $content.Replace("@@guid@@", "$(New-Guid)")
        $content = $content.Replace("@@author@@", $author)
        $content = $content.Replace("@@description@@", $description)
    }
}
process {	
	Write-Verbose "$PSScriptName $name $template start"
    if($PSCmdlet.ShouldProcess($name)) {
        if ($PersistForCurrentUser) {
            Write-Verbose "PersistForCurrentUser-repos:$repos,template:$template"
            [Environment]::SetEnvironmentVariable("$eKey-$rKey", $repos, $scope)
            if ($template) { [Environment]::SetEnvironmentVariable("$eKey-$tKey", $template, $scope) }
            if (!$name) { Exit 0 }
        }

        if (Test-Path $path) {
            if (!$Force) {
                Write-Error "ERROR $path already exists. Use -Force to overwrite."
                EXIT 1
            } else {
                Write-Verbose "$path already exist. -Force used - removing."
                if ($pwd = $path) { Set-Location $ReposFolder }
                #Remove-Item $path -Recurse -Force | Out-Null
            }
        }

        if (!(Test-Path $path)) {
            Write-Verbose "Creating: $path"
            #New-Item -Path $path -ItemType Directory | Out-Null
        }

        $templatePath = Join-Path $repos $template
        if (Test-Path $templatePath) {
            Write-Verbose "Copying template: $templatePath to $path"
			#Copy-Item -Path "$templatePath\*" -Destination $path -PassThru -Recurse -Exclude '.git',"$template.ps1" -Force | Out-Null
        }

        if ($template = $PSScriptName) {
            $content = $content.Replace("Template-Script", $name)
            $content = $content.Replace("beae9bf9-f016-416e-8443-d756a8799ff9", "$(New-Guid)")
            if ($author -ne "david") {
                $content = $content.Replace($templateAuthor, $author)
            }
            $content = $content.Replace("Create PowerShell Script in folder [Name]/[Name].ps1 based on template", $description)
            $content = $content.Replace("Template and Repos (aka Destination path) can be persisted using -PersistForCurrentUser", "")
        } else {
            $content = $content.Replace($template, $name)
            $content = $content.Replace("@@guid@@", "$(New-Guid)")
            $content = $content.Replace("@@author@@", $author)
            $content = $content.Replace("@@description@@", $description)
        }
        Write-Verbose "Creating: $path\$name.ps1"
        #$content | Out-File (Join-Path $path "$name.ps1")

        $ignorePath = Join-Path $path ".gitignore"
        if (!(Test-Path $ignorePath)) {
            Write-Verbose "Creating: $ignorePath"
            #"# User-specific files" | Out-File $ignorePath
        }

        $readmePath = Join-Path $path "README.md"
        if (!(Test-Path $readmePath)) {
            $content = "# $name`r`n@@description@@"
        } else {
            $content = Get-Content ($readmePath)
            $content = $content.Replace($template, $name)
        }
        $content = $content.Replace("@@description@@", $description)
        Write-Verbose "Creating: $readmePath"
        #$content | Out-File $readmePath

        $licensePath = Join-Path $path "LICENSE"
        if (!(Test-Path $licensePath)) {
            $content = Get-Content ((Join-Path $PSScriptFolder "LICENSE"))
            $content = $content.Replace($templateAuthor, $author)
        } else {
            $content = Get-Content ($licensePath)
            $content = $content.Replace("@@author@@", $author)
        }
        Write-Verbose "Creating: $licensePath"
        #$content | Out-File $licensePath
    }
    Write-Verbose "$PSScriptName $name end"
    if ($PersistForCurrentUser) { Set-Location $path }
    return $path
}