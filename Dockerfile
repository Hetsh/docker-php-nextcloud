FROM alpine:3.11.2
RUN apk add --no-cache \
    php7-fpm=7.3.13-r0 \
    php7-bz2=7.3.13-r0 \
    php7-curl=7.3.13-r0 \
    php7-exif=7.3.13-r0 \
    php7-gd=7.3.13-r0 \
    php7-gmp=7.3.13-r0 \
    php7-iconv=7.3.13-r0 \
    php7-imap=7.3.13-r0 \
    php7-intl=7.3.13-r0 \
    php7-ldap=7.3.13-r0 \
    php7-opcache=7.3.13-r0 \
    php7-pdo_sqlite=7.3.13-r0 \
    php7-sqlite3=7.3.13-r0 \
    php7-zip=7.3.13-r0 \
    php7-pecl-imagick=3.4.4-r2 \
    php7-pecl-mcrypt=1.0.3-r0

ARG WWW_CONF="/etc/php7/php-fpm.d/www.conf"
RUN sed -i "s|;env\[PATH\]|env\[PATH\]|" "$WWW_CONF" && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|" "$WWW_CONF"

EXPOSE 9000/tcp
#      PHP-FPM

ENTRYPOINT exec php-fpm7 --nodaemonize --force-stderr --fpm-config /etc/php7/php-fpm.conf
