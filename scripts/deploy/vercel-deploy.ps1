param(
    [Parameter(Mandatory = $true)]
    [string]$ApiBaseUrl,

    [string]$ProjectPath = ".",
    [string]$VercelToken = "",
    [string]$Scope = ""
)

$ErrorActionPreference = "Stop"

function Invoke-Vercel {
    param([string[]]$Args)
    & vercel @Args
    if ($LASTEXITCODE -ne 0) {
        throw "Vercel command failed: vercel $($Args -join ' ')"
    }
}

if (-not (Get-Command vercel -ErrorAction SilentlyContinue)) {
    throw "Vercel CLI not found. Install it with: npm i -g vercel"
}

Push-Location $ProjectPath
try {
    $commonArgs = @()
    if ($VercelToken) {
        $commonArgs += @("--token", $VercelToken)
    }
    if ($Scope) {
        $commonArgs += @("--scope", $Scope)
    }

    Write-Host "Linking project settings from Vercel..."
    Invoke-Vercel -Args (@("pull", "--yes", "--environment=production") + $commonArgs)

    Write-Host "Updating production env var VITE_API_BASE_URL..."
    & vercel env rm VITE_API_BASE_URL production --yes @commonArgs | Out-Null
    $ApiBaseUrl | & vercel env add VITE_API_BASE_URL production @commonArgs
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to set VITE_API_BASE_URL."
    }

    Write-Host "Deploying to Vercel production..."
    Invoke-Vercel -Args (@("--prod", "--yes") + $commonArgs)
}
finally {
    Pop-Location
}
