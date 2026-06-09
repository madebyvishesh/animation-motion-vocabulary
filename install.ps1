param(
  [Parameter(Position = 0)]
  [ValidateSet("codex", "claude", "all", "custom", "help")]
  [string]$Target = "help",

  [Parameter(Position = 1)]
  [string]$CustomPath
)

$ErrorActionPreference = "Stop"

$SkillName = "animation-motion-vocabulary"
$Repo = "madebyvishesh/animation-motion-vocabulary"
$Ref = if ($env:ANIMATION_VOCAB_REF) { $env:ANIMATION_VOCAB_REF } else { "main" }
$script:TempDir = $null

function Show-Usage {
  @"
Usage:
  .\install.ps1 codex
  .\install.ps1 claude
  .\install.ps1 all
  .\install.ps1 custom C:\path\to\skills

Remote install:
  powershell -NoProfile -ExecutionPolicy Bypass -Command "& ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.ps1'))) codex"
  powershell -NoProfile -ExecutionPolicy Bypass -Command "& ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.ps1'))) claude"
"@
}

function Get-SkillSource {
  $scriptDir = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
  $localSkillDir = Join-Path $scriptDir $SkillName

  if (Test-Path (Join-Path $localSkillDir "SKILL.md")) {
    return $localSkillDir
  }

  $script:TempDir = Join-Path ([System.IO.Path]::GetTempPath()) ([System.Guid]::NewGuid().ToString())
  New-Item -ItemType Directory -Force -Path $script:TempDir | Out-Null

  $zipPath = Join-Path $script:TempDir "repo.zip"
  $extractDir = Join-Path $script:TempDir "repo"
  $url = "https://github.com/$Repo/archive/refs/heads/$Ref.zip"

  Write-Host "Downloading $Repo@$Ref..."
  Invoke-WebRequest -Uri $url -OutFile $zipPath
  Expand-Archive -Path $zipPath -DestinationPath $extractDir -Force

  $repoDir = Get-ChildItem -Path $extractDir -Directory | Select-Object -First 1
  if (-not $repoDir) {
    throw "Could not extract repository archive."
  }

  return (Join-Path $repoDir.FullName $SkillName)
}

function Copy-Skill {
  param([string]$TargetRoot)

  $skillSource = Get-SkillSource
  $skillFile = Join-Path $skillSource "SKILL.md"

  if (-not (Test-Path $skillFile)) {
    throw "SKILL.md not found at $skillFile"
  }

  New-Item -ItemType Directory -Force -Path $TargetRoot | Out-Null

  $targetDir = Join-Path $TargetRoot $SkillName
  if (Test-Path $targetDir) {
    Remove-Item -Recurse -Force $targetDir
  }

  Copy-Item -Recurse -Path $skillSource -Destination $targetDir
  Write-Host "Installed $SkillName to $targetDir"
}

try {
  switch ($Target) {
    "codex" {
      Copy-Skill (Join-Path $HOME ".codex\skills")
    }
    "claude" {
      Copy-Skill (Join-Path $HOME ".claude\skills")
    }
    "all" {
      Copy-Skill (Join-Path $HOME ".codex\skills")
      Copy-Skill (Join-Path $HOME ".claude\skills")
    }
    "custom" {
      if (-not $CustomPath) {
        throw "Custom install requires a target directory."
      }
      Copy-Skill $CustomPath
    }
    default {
      Show-Usage
    }
  }
}
finally {
  if ($script:TempDir -and (Test-Path $script:TempDir)) {
    Remove-Item -Recurse -Force $script:TempDir
  }
}
