param(
    [Parameter(Mandatory = $true)]
    [string]$RenderApiKey,

    [Parameter(Mandatory = $true)]
    [string]$ServiceId,

    [Parameter(Mandatory = $true)]
    [string]$AppKey,

    [Parameter(Mandatory = $true)]
    [string]$AppUrl,

    [Parameter(Mandatory = $true)]
    [string]$DbHost,

    [Parameter(Mandatory = $true)]
    [string]$DbDatabase,

    [Parameter(Mandatory = $true)]
    [string]$DbUsername,

    [Parameter(Mandatory = $true)]
    [string]$DbPassword,

    [Parameter(Mandatory = $true)]
    [string]$CorsAllowedOrigins
)

$ErrorActionPreference = "Stop"
$base = "https://api.render.com/v1"
$headers = @{
    Authorization = "Bearer $RenderApiKey"
    "Content-Type" = "application/json"
}

function Set-RenderEnvVar {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Key,
        [Parameter(Mandatory = $true)]
        [string]$Value
    )

    $body = @{ value = $Value } | ConvertTo-Json
    $uri = "$base/services/$ServiceId/env-vars/$Key"
    Invoke-RestMethod -Method Put -Uri $uri -Headers $headers -Body $body | Out-Null
    Write-Host "Set $Key"
}

Set-RenderEnvVar -Key "APP_KEY" -Value $AppKey
Set-RenderEnvVar -Key "APP_ENV" -Value "production"
Set-RenderEnvVar -Key "APP_DEBUG" -Value "false"
Set-RenderEnvVar -Key "APP_URL" -Value $AppUrl
Set-RenderEnvVar -Key "DB_CONNECTION" -Value "pgsql"
Set-RenderEnvVar -Key "DB_HOST" -Value $DbHost
Set-RenderEnvVar -Key "DB_PORT" -Value "5432"
Set-RenderEnvVar -Key "DB_DATABASE" -Value $DbDatabase
Set-RenderEnvVar -Key "DB_USERNAME" -Value $DbUsername
Set-RenderEnvVar -Key "DB_PASSWORD" -Value $DbPassword
Set-RenderEnvVar -Key "DB_SSLMODE" -Value "require"
Set-RenderEnvVar -Key "CORS_ALLOWED_ORIGINS" -Value $CorsAllowedOrigins

Write-Host "Triggering Render deploy..."
$deploy = Invoke-RestMethod -Method Post -Uri "$base/services/$ServiceId/deploys" -Headers $headers -Body "{}"

Write-Host ""
Write-Host "Render deploy triggered."
Write-Host "DEPLOY_ID=$($deploy.id)"
Write-Host "STATUS=$($deploy.status)"
