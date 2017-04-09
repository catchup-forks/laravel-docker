FROM php:7.1.2-fpm

RUN apt-get update -y \
    && apt-get install -yqq --no-install-recommends \
      ca-certificates wget xvfb unzip zlib1g-dev \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/build?os=linux&arch=amd64&features=expires%2Cgit%2Crealip" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
    && chmod 0755 /usr/bin/caddy \
    && /usr/bin/caddy -version \
    && docker-php-ext-install mbstring pdo pdo_mysql zip


COPY src/ /srv/app
COPY entrypoint.sh /opt/bin/entrypoint.sh
COPY config/Caddyfile /etc/Caddyfile

WORKDIR /srv/app

RUN chmod +x /opt/bin/entrypoint.sh \
    && mkdir -p /srv/app/bootstrap/cache \
    && mkdir -p /srv/app/storage/app/public \
    && mkdir -p /srv/app/storage/framework/cache \
    && mkdir -p /srv/app/storage/framework/sessions \
    && mkdir -p /srv/app/storage/framework/views \
    && mkdir -p /srv/app/storage/logs \
    && touch /srv/app/storage/logs/laravel.log \
    && chown -R www-data:www-data /srv/app

EXPOSE 80 443 2015

CMD ["/opt/bin/entrypoint.sh"]
