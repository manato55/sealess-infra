FROM php:7.4-fpm-buster
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

ARG DB_CONNECTION
ARG DB_HOST
ARG DB_DATABASE
ARG DB_USERNAME
ARG DB_PASSWORD
ARG APP_URL
ARG ALLOWED_ORIGIN
ARG MAIL_MAILER
ARG MAIL_HOST
ARG MAIL_PORT
ARG MAIL_USERNAME
ARG MAIL_PASSWORD
ARG MAIL_ENCRYPTION
ARG MAIL_FROM_ADDRESS

# timezone environment
ENV TZ=Asia/Tokyo \
  # locale
  LANG=ja_JP.UTF-8 \
  LANGUAGE=ja_JP:ja \
  LC_ALL=ja_JP.UTF-8 \
  # composer environment
  COMPOSER_ALLOW_SUPERUSER=1 \
  COMPOSER_HOME=/composer \
  # laravel environment
  DB_CONNECTION=${DB_CONNECTION} \
  DB_HOST=${DB_HOST} \
  DB_DATABASE=${DB_DATABASE} \
  DB_USERNAME=${DB_USERNAME} \
  DB_PASSWORD=${DB_PASSWORD} \
  APP_URL=${APP_URL} \
  MAIL_MAILER=${MAIL_MAILER} \
  MAIL_HOST=${MAIL_HOST} \
  MAIL_PORT=${MAIL_PORT} \
  MAIL_USERNAME=${MAIL_USERNAME} \
  MAIL_PASSWORD=${MAIL_PASSWORD} \
  MAIL_ENCRYPTION=${MAIL_ENCRYPTION} \
  MAIL_FROM_ADDRESS=${MAIL_FROM_ADDRESS} \
  ALLOWED_ORIGIN=${ALLOWED_ORIGIN} 


COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# install composer
RUN apt-get update && \
  apt-get -y install git cron libicu-dev libgmp-dev libonig-dev libzip-dev unzip locales libfreetype6-dev libjpeg62-turbo-dev libpng-dev imagemagick libmagickwand-dev && \
  apt-get clean && \
  pecl install imagick && \
  rm -rf /var/lib/apt/lists/* && \
  locale-gen en_US.UTF-8 && \
  localedef -f UTF-8 -i en_US en_US.UTF-8 && \
  mkdir /var/run/php-fpm && \
  docker-php-ext-configure gmp && \
  docker-php-ext-configure gd --with-freetype --with-jpeg && \
  docker-php-ext-install gmp intl pdo_mysql mbstring zip gmp bcmath -j$(nproc) gd && \
  docker-php-ext-enable imagick && \
  composer config -g process-timeout 3600 && \
  composer config -g repos.packagist composer https://packagist.org
  # push通知に必要なmodule
  # apt-get install -y libgmp-dev
  # docker-php-ext-configure gmp
  # docker-php-ext-install gmp

USER root
COPY ./root /etc/cron.d
RUN chmod -R 644 /etc/cron.d && \
    touch /var/log/cron.log


# install node.js
COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs && \
  ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm && \
  ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npx 

# install xdebug
RUN pecl install xdebug && \
  docker-php-ext-enable xdebug

COPY ./php-fpm.d/zzz-www.conf /usr/local/etc/php-fpm.d/zzz-www.conf
COPY ./php.ini /usr/local/etc/php/php.ini

WORKDIR /work/backend

# dockerfileに CMD cron -f は入れずに、dockerを起動させてから service cron start とする

# CMD cron -f