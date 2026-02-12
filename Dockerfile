FROM php:8.2-apache

ENV APP_ENV=production
ENV APP_DEBUG=false
ENV VIEW_COMPILED_PATH=/var/www/html/storage/framework/views

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    libzip-dev \
    default-mysql-client \
    && docker-php-ext-install pdo pdo_pgsql pgsql pdo_mysql zip \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# 1) Install dependencies WITHOUT running scripts
COPY composer.json composer.lock ./
RUN composer install --no-dev --no-scripts --prefer-dist --no-interaction --optimize-autoloader

# 2) Copy app source
COPY . .

# Drop any local cached Laravel artifacts bundled from the host.
RUN rm -f bootstrap/cache/*.php

# 3) Create required runtime dirs + permissions (prevents 500s)
RUN mkdir -p storage/framework/cache \
             storage/framework/sessions \
             storage/framework/views \
             storage/framework/testing \
             storage/logs \
             bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R ug+rwx storage bootstrap/cache \
    && cp docker/vhost.conf /etc/apache2/sites-available/000-default.conf

# 4) Optimize autoload (now that code is present)
RUN composer dump-autoload --optimize --no-dev

# 5) Entrypoint
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

CMD ["/usr/local/bin/entrypoint.sh"]
