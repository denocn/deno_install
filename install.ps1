#!/usr/bin/env pwsh
# Copyright 2018-2020 the Deno authors. All rights reserved. MIT license.
# TODO(everyone): Keep this script simple and easily auditable.

$ErrorActionPreference = 'Stop'

if ($args.Length -gt 0) {
  $Version = $args.Get(0)
}

if ($PSVersionTable.PSEdition -ne 'Core') {
  $IsWindows = $true
  $IsMacOS = $false
}

$DenoInstall = $env:DENO_INSTALL
$BinDir = if ($DenoInstall) {
    "$DenoInstall\bin"
} elseif ($IsWindows) {
  "$Home\.deno\bin"
}

$DenoZip = "$BinDir\deno.zip"

$DenoExe = "$BinDir\deno.exe"

$Target = 'x86_64-pc-windows-msvc'

# GitHub requires TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if (!$Version) {
  $Versions = (Invoke-WebRequest 'https://x.deno.js.cn/versions.txt' -UseBasicParsing).Content -split '\n'
  $Version = $Versions[0]
}

$DenoUri = "http://deno.devtips.cn/releases/download/$Version/deno-${Target}.zip"

if (!(Test-Path $BinDir)) {
  New-Item $BinDir -ItemType Directory | Out-Null
}

Invoke-WebRequest $DenoUri -OutFile $DenoZip -UseBasicParsing

Expand-Archive $DenoZip -Destination $BinDir -Force
Remove-Item $DenoZip

$User = [EnvironmentVariableTarget]::User
$Path = [Environment]::GetEnvironmentVariable('Path', $User)
if (!(";$Path;".ToLower() -like "*;$BinDir;*".ToLower())) {
  [Environment]::SetEnvironmentVariable('Path', "$Path;$BinDir", $User)
  $Env:Path += ";$BinDir"
}
Write-Output "Deno �Ѿ��ɹ���װ��"
Write-Output "��ִ���ļ�λ��Ϊ $DenoExe"
Write-Output "���� 'deno --help' �鿴 Deno ������Ϣ��"
