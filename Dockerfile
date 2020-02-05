FROM alpine:3.11.3
RUN apk add --no-cache \
    php7-fpm=7.3.14-r0 \
    php7-bz2=7.3.14-r0 \
    php7-curl=7.3.14-r0 \
    php7-exif=7.3.14-r0 \
    php7-gd=7.3.14-r0 \
    php7-gmp=7.3.14-r0 \
    php7-iconv=7.3.14-r0 \
    php7-imap=7.3.14-r0 \
    php7-intl=7.3.14-r0 \
    php7-ldap=7.3.14-r0 \
    php7-opcache=7.3.14-r0 \
    php7-pdo_sqlite=7.3.14-r0 \
    php7-sqlite3=7.3.14-r0 \
    php7-zip=7.3.14-r0 \
    php7-pecl-imagick=3.4.4-r2 \
    php7-pecl-mcrypt=1.0.3-r0

ARG APP_USER="http"
#RUN sed -i "s|xfs|$APP_USER|" "/etc/passwd" && \
#    sed -i "s|/etc/X11/fs|/srv|" "/etc/passwd"
RUN adduser --uid "100" --system --no-create-home --home "/srv" --gecos "$APP_USER" "$APP_USER"

ARG WWW_CONF="/etc/php7/php-fpm.d/www.conf"
RUN sed -i "s|user.*|user = $APP_USER|" "$WWW_CONF" && \
    sed -i "s|;env\[PATH\]|env\[PATH\]|" "$WWW_CONF" && \
    sed -i "s|listen.*|listen = 9000|" "$WWW_CONF" && \
    sed -i "s|;catch_workers_output.*|catch_workers_output = yes|" "$WWW_CONF" && \
    sed -i "s|;decorate_workers_output.*|decorate_workers_output = no|" "$WWW_CONF" && \
    sed -i "s|;access\.log.*|access\.log = /proc/self/fd/2|" "$WWW_CONF"

ARG PHP_INI="/etc/php7/php.ini"
RUN sed -i "s|upload_max_filesize.*|upload_max_filesize = 1024M|" "$PHP_INI" && \
    sed -i "s|;error_log.*|error_log = /proc/self/fd/2|" "$PHP_INI"

EXPOSE 9000/tcp
#      PHP-FPM

ENTRYPOINT ["php-fpm7", "--nodaemonize", "--force-stderr", "--fpm-config", "/etc/php7/php-fpm.conf"]
