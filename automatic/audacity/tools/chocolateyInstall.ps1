﻿$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName    = 'audacity'
  fileType       = 'exe'
  file           = "$toolsDir\audacity-win-3.2.5-x32.exe"
  file64         = "$toolsDir\audacity-win-3.2.5-x64.exe"
  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0, 1223)
}
Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem "$toolsDir\*.$($packageArgs.fileType)" | ForEach-Object {
  Remove-Item $_ -ea 0
  if (Test-Path $_) {
    Set-Content "$_.ignore"
  }
}

$pp = Get-PackageParameters
$mergeTasks = Get-MergeTasks $pp
$packageArgs.silentArgs += ' /MERGETASKS="{0}"' -f $mergeTasks

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation) {
  Write-Host "$packageName installed to '$installLocation'"
  Register-Application "$installLocation\$packageName.exe"
  Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
