FROM hetsh/php-fpm:7.3.16-4
RUN apk add --no-cache \
    php7-bz2=7.3.16-r2 \
    php7-curl=7.3.16-r2 \
    php7-exif=7.3.16-r2 \
    php7-gd=7.3.16-r2 \
    php7-gmp=7.3.16-r2 \
    php7-iconv=7.3.16-r2 \
    php7-imap=7.3.16-r2 \
    php7-intl=7.3.16-r2 \
    php7-ldap=7.3.16-r2 \
    php7-opcache=7.3.16-r2 \
    php7-pdo_sqlite=7.3.16-r2 \
    php7-sqlite3=7.3.16-r2 \
    php7-zip=7.3.16-r2 \
    php7-pecl-imagick=3.4.4-r3 \
    php7-pecl-mcrypt=1.0.3-r0

ARG PHP_INI="/etc/php7/php.ini"
RUN sed -i "s|upload_max_filesize.*|upload_max_filesize = 1024M|" "$PHP_INI"
