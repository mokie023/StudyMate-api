param(
    [Parameter(Mandatory = $true)]
    [string]$NeonApiKey,

    [Parameter(Mandatory = $true)]
    [string]$ProjectName,

    [string]$RegionId = "aws-us-east-2",
    [int]$PostgresVersion = 16,
    [string]$DatabaseName = "neondb",
    [string]$RoleName = "neondb_owner"
)

$ErrorActionPreference = "Stop"

$headers = @{
    Authorization = "Bearer $NeonApiKey"
    "Content-Type" = "application/json"
}

$createBody = @{
    project = @{
        name = $ProjectName
        region_id = $RegionId
        pg_version = $PostgresVersion
        branch = @{
            name = "main"
            database_name = $DatabaseName
            role_name = $RoleName
        }
    }
} | ConvertTo-Json -Depth 10

Write-Host "Creating Neon project '$ProjectName' in region '$RegionId'..."
$createResponse = Invoke-RestMethod -Method Post -Uri "https://console.neon.tech/api/v2/projects" -Headers $headers -Body $createBody

$projectId = $createResponse.project.id
if (-not $projectId) {
    throw "Failed to create project: missing project ID in response."
}

$branchId = $createResponse.branch.id
if (-not $branchId) {
    throw "Failed to detect branch ID from create response."
}

Write-Host "Retrieving connection URI..."
$uri = "https://console.neon.tech/api/v2/projects/$projectId/connection_uri?branch_id=$branchId&database_name=$DatabaseName&role_name=$RoleName"
$connResponse = Invoke-RestMethod -Method Get -Uri $uri -Headers $headers

$connectionUri = $connResponse.uri
if (-not $connectionUri) {
    throw "Failed to retrieve connection URI."
}

$parsed = [System.Uri]$connectionUri
$userInfo = $parsed.UserInfo.Split(":", 2)
$dbUser = $userInfo[0]
$dbPass = if ($userInfo.Count -gt 1) { $userInfo[1] } else { "" }
$dbName = $parsed.AbsolutePath.TrimStart("/")

Write-Host ""
Write-Host "Neon project created successfully."
Write-Host "PROJECT_ID=$projectId"
Write-Host "BRANCH_ID=$branchId"
Write-Host "DATABASE_URL=$connectionUri"
Write-Host ""
Write-Host "Render env values:"
Write-Host "DB_CONNECTION=pgsql"
Write-Host "DB_HOST=$($parsed.Host)"
Write-Host "DB_PORT=$($parsed.Port)"
Write-Host "DB_DATABASE=$dbName"
Write-Host "DB_USERNAME=$dbUser"
Write-Host "DB_PASSWORD=$dbPass"
