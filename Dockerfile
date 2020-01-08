FROM alpine:3.11.2
RUN apk add --no-cache php7-fpm=7.3.13-r0

ARG WWW_CONF="/etc/php7/php-fpm.d/www.conf"
RUN sed -i "s|;env\[PATH\]|env\[PATH\]|" "$WWW_CONF"
RUN sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|" "$WWW_CONF"

EXPOSE 9000/tcp
#      PHP-FPM

ENTRYPOINT exec php-fpm7 --nodaemonize --force-stderr --fpm-config /etc/php7/php-fpm.conf
