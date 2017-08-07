FROM richarvey/nginx-php-fpm:php5

ENV COMPOSER_VERSION 1.1.2

RUN apk update && \
    apk upgrade && \
    apk add --update curl openssl && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} && \
    chmod +x /usr/local/bin/composer && \
    apk del curl openssl && \
    rm -rf /var/cache/apk/*

COPY index.php /var/www/html/
COPY composer.json /var/www/html/

RUN cd /var/www/html && \
    composer install
