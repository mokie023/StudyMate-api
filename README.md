# StudentAcademicToolkit

Decoupled application scaffold:

- `backend/`: Laravel API
- `frontend/`: React + Vite UI
- `legacy-php/`: placeholder for old monolith code
- `docs/`: architecture and migration notes
- `database/`: dump placeholders and mapping notes

## How to run locally

### Backend (Laravel API)
1. `cd backend`
2. `composer install`
3. `cp .env.example .env` (PowerShell: `Copy-Item .env.example .env`)
4. `php artisan key:generate`
5. `php artisan serve`

### Frontend (React + Vite)
1. `cd frontend`
2. `npm install`
3. `npm run dev`

## CORS and API URL

- Set frontend API base URL in `frontend/.env` from `frontend/.env.example`.
- Default is `VITE_API_URL=http://127.0.0.1:8000`.
- Ensure backend CORS allows your frontend origin (for example `http://localhost:5173`).
