# Deployment Automation (Laravel + Neon + Render + Vercel)

## 1) Backend Docker setup (already added)

This repository now includes:
- `Dockerfile`
- `docker/entrypoint.sh` (runs `php artisan migrate --force` on startup)
- `docker/vhost.conf`
- `.dockerignore`

Render should be configured to use Docker deploy from this repo root.

## 2) Create Neon DB and export DB values

Run:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/deploy/neon-setup.ps1 `
  -NeonApiKey "YOUR_NEON_API_KEY" `
  -ProjectName "studymate-prod"
```

The script prints:
- `DB_HOST`
- `DB_DATABASE`
- `DB_USERNAME`
- `DB_PASSWORD`

## 3) Generate Laravel APP_KEY

Run from backend project:

```powershell
php artisan key:generate --show
```

Copy the output (format: `base64:...`).

## 4) Set Render env vars and trigger deploy

Run:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/deploy/render-deploy.ps1 `
  -RenderApiKey "YOUR_RENDER_API_KEY" `
  -ServiceId "YOUR_RENDER_SERVICE_ID" `
  -AppKey "base64:YOUR_APP_KEY" `
  -AppUrl "https://your-backend-domain.com" `
  -DbHost "YOUR_NEON_HOST" `
  -DbDatabase "YOUR_NEON_DB" `
  -DbUsername "YOUR_NEON_USER" `
  -DbPassword "YOUR_NEON_PASSWORD" `
  -CorsAllowedOrigins "https://your-vercel-domain.vercel.app"
```

This will:
- Set required environment variables in Render.
- Trigger a fresh deploy.
- Startup automatically runs migrations via `docker/entrypoint.sh`.

## 5) Deploy React frontend on Vercel

From your React project directory:

```powershell
powershell -ExecutionPolicy Bypass -File ..\StudyMate-api\scripts\deploy\vercel-deploy.ps1 `
  -ApiBaseUrl "https://your-backend-domain.com" `
  -ProjectPath "."
```

If needed, pass:
- `-VercelToken "YOUR_VERCEL_TOKEN"`
- `-Scope "YOUR_TEAM_OR_ACCOUNT"`

Expected frontend settings:
- Build command: `npm run build`
- Output directory: `dist`
- Env var: `VITE_API_BASE_URL=https://your-backend-domain.com`

## 6) Verify secure frontend/backend connectivity

1. Confirm backend health endpoint from browser/Postman.
2. Confirm browser network requests from Vercel app go to `https://your-backend-domain.com`.
3. Confirm CORS response headers allow only your configured origin.
4. Confirm DB-backed API endpoints work (proves Render -> Neon connectivity).
