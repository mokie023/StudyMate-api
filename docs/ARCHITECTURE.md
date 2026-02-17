# Architecture

## Overview
- `frontend/` (React + Vite) is a pure UI client.
- `backend/` (Laravel) exposes REST APIs under `/api/v1`.
- `legacy-php/` stores the old monolith for phased migration.

## Request Flow
1. User interacts with React pages/components.
2. Frontend calls API via `src/lib/http.js`.
3. Laravel controllers validate requests using Form Requests.
4. Controllers return JSON responses.

## Auth
- Token-based auth flow.
- Frontend stores token in `localStorage`.
- `http.js` attaches `Authorization: Bearer <token>` headers.

## Uploads
- User uploads are stored in backend private storage:
  - `backend/storage/app/uploads/users`
- This avoids writing directly to public web root.
