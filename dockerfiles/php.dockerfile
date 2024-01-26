FROM php:8.2-fpm-alpine

WORKDIR /var/www/laravel

ARG USER_ID

RUN apk update
RUN apk upgrade

# Встановлюємо необхідні пакети
RUN apk add \
    zip \
    libzip-dev \
    && rm -rf /var/lib/apt/lists/*

# Встановлюємо розширення PHP

RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install zip
