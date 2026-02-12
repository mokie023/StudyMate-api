#!/usr/bin/env bash
set -e

APP_DIR="/var/www/html"

PORT="${PORT:-10000}"
echo "Starting Apache on PORT=${PORT}"
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

# Render assigns a dynamic port; make Apache listen on it.
sed -ri "s/^Listen 80$/Listen ${PORT}/" /etc/apache2/ports.conf
sed -ri "s/<VirtualHost \*:80>/<VirtualHost *:${PORT}>/" /etc/apache2/sites-available/000-default.conf

# Silence Apache startup warning about missing ServerName.
echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf
a2enconf servername >/dev/null 2>&1 || true

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
CACHE_DRIVER=array php artisan cache:clear || true

# ------------------------------------------------------------
# 4) Migrate only when DB configured
# ------------------------------------------------------------
if [ -z "${DATABASE_URL:-}" ] && [ -z "${DB_HOST:-}" ]; then
  echo "No DATABASE_URL/DB_HOST set. Skipping migrations."
else
  echo "Running migrations..."
  if php artisan migrate --force --no-interaction; then
    echo "Migrations complete."
  else
    echo "Skipping migrate (DB not reachable / bad credentials / migration error)"
  fi
fi

# ------------------------------------------------------------
# 5) Start Apache
# ------------------------------------------------------------
export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data

apache2-foreground
