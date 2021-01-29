#!/usr/bin/env pwsh
# Copyright 2018-2020 the Deno authors. All rights reserved. MIT license.
# TODO(everyone): Keep this script simple and easily auditable.

$ErrorActionPreference = 'Stop'

if ($v) {
  $Version = "${v}"
}

if ($args.Length -eq 1) {
  $Version = $args.Get(0)
}

$DenoInstall = $env:DENO_INSTALL
$BinDir = if ($DenoInstall) {
  "$DenoInstall\bin"
} else {
  "$Home\.deno\bin"
}

$DenoZip = "$BinDir\deno.zip"
$DenoExe = "$BinDir\deno.exe"
$Target = 'x86_64-pc-windows-msvc'

# GitHub requires TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if (!$Version) {
  $Version = (Invoke-WebRequest 'https://dl.deno.land/release-latest.txt' -UseBasicParsing).Content.Trim()
}

$Version = $Version.Replace("v","")

if ($Version -match "1.[0-6]+.[0-9]+") {
  $DenoUri = "https://cdn.jsdelivr.net/gh/justjavac/deno_releases/$Version/deno-${Target}.zip"
} else {
  $DenoUri = "https://dl.deno.land/release/v${Version}/deno-${Target}.zip"
}

if (!(Test-Path $BinDir)) {
  New-Item $BinDir -ItemType Directory | Out-Null
}

Invoke-WebRequest $DenoUri -OutFile $DenoZip -UseBasicParsing

if (Get-Command Expand-Archive -ErrorAction SilentlyContinue) {
  Expand-Archive $DenoZip -Destination $BinDir -Force
} else {
  if (Test-Path $DenoExe) {
    Remove-Item $DenoExe
  }
  Add-Type -AssemblyName System.IO.Compression.FileSystem
  [IO.Compression.ZipFile]::ExtractToDirectory($DenoZip, $BinDir)
}

Remove-Item $DenoZip

$User = [EnvironmentVariableTarget]::User
$Path = [Environment]::GetEnvironmentVariable('Path', $User)
if (!(";$Path;".ToLower() -like "*;$BinDir;*".ToLower())) {
  [Environment]::SetEnvironmentVariable('Path', "$Path;$BinDir", $User)
  $Env:Path += ";$BinDir"
}

Write-Output "Deno 已经成功安装"
Write-Output "可执行文件位置为 $DenoExe"
Write-Output "运行 'deno --help' 查看 Deno 帮助信息"
