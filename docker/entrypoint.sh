#!/usr/bin/env bash
set -e

APP_DIR="/var/www/html"

echo "Starting Apache on PORT=${PORT:-10000}"
cd "$APP_DIR"

# ------------------------------------------------------------
# 1) Required Laravel runtime directories (fix sessions/views)
# ------------------------------------------------------------
mkdir -p storage/framework/cache \
         storage/framework/sessions \
         storage/framework/views \
         storage/framework/testing \
         storage/logs \
         bootstrap/cache

chown -R www-data:www-data storage bootstrap/cache || true
chmod -R ug+rwx storage bootstrap/cache || true

# ------------------------------------------------------------
# 2) Required app key
# ------------------------------------------------------------
if [ -z "${APP_KEY:-}" ]; then
  echo "ERROR: APP_KEY is missing. Set APP_KEY in Render env vars."
  exit 1
fi

# ------------------------------------------------------------
# 3) Clear caches safely
# ------------------------------------------------------------
php artisan config:clear || true
php artisan route:clear  || true
php artisan view:clear   || true
php artisan cache:clear  || true

# ------------------------------------------------------------
# 4) Migrate only when DB configured & reachable
# ------------------------------------------------------------
if [ -z "${DATABASE_URL:-}" ] && [ -z "${DB_HOST:-}" ]; then
  echo "No DATABASE_URL/DB_HOST set. Skipping DB checks & migrations."
else
  if php artisan db:monitor >/dev/null 2>&1; then
    echo "DB reachable ✅ Running migrations..."
    php artisan migrate --force || true
  else
    echo "Skipping migrate (DB not reachable / bad credentials)"
  fi
fi

# ------------------------------------------------------------
# 5) Start Apache
# ------------------------------------------------------------
export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data

apache2-foreground
