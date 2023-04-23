FROM php:7.4-fpm

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

COPY . .

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN composer install \
    --no-interaction

RUN php artisan optimize

EXPOSE 8000

CMD php artisan serve --host=0.0.0.0 --port=8000
