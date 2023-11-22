FROM php:8.2-fpm-alpine

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

# Перевіряємо наявність групи www-data перед створенням
RUN if ! getent group www-data >/dev/null; then \
      addgroup -g ${GROUP_ID} www-data; \
    fi

# Створюємо користувача www-data та встановлюємо йому домашню директорію
# Перевіряємо наявність користувача www-data перед створенням
RUN if ! getent passwd www-data >/dev/null; then \
      adduser -D -G www-data -u ${USER_ID} -s /bin/bash -h /home/www-data www-data; \
    fi

# Змінюємо власника директорій на www-data
RUN chown -R www-data:www-data /var/www/

# Вказуємо робочу директорію та власника
WORKDIR /var/www/laravel