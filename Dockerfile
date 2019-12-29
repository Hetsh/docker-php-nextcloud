FROM alpine:3.11.2
RUN apk add --no-cache php7-fpm=7.3.13-r0

EXPOSE 9000/tcp
#      PHP-FPM

ENTRYPOINT exec php-fpm7 --nodaemonize --force-stderr --fpm-config /etc/php7/php-fpm.conf
