FROM hetsh/php84-fpm:8.4.13-1
ARG LAST_UPGRADE="2025-10-13T20:12:33+02:00"
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk upgrade && \
    apk add --no-cache \
        imagemagick-svg=7.1.2.3-r1 \
        php84-bcmath=8.4.13-r0 \
        php84-bz2=8.4.13-r0 \
        php84-ctype=8.4.13-r0 \
        php84-curl=8.4.13-r0 \
        php84-dom=8.4.13-r0 \
        php84-exif=8.4.13-r0 \
        php84-fileinfo=8.4.13-r0 \
        php84-gd=8.4.13-r0 \
        php84-gmp=8.4.13-r0 \
        php84-iconv=8.4.13-r0 \
        php84-intl=8.4.13-r0 \
        php84-ldap=8.4.13-r0 \
        php84-mbstring=8.4.13-r0 \
        php84-opcache=8.4.13-r0 \
        php84-openssl=8.4.13-r0 \
        php84-pcntl=8.4.13-r0 \
        php84-pdo_mysql=8.4.13-r0 \
        php84-pdo_sqlite=8.4.13-r0 \
        php84-pecl-imagick=3.8.0-r1 \
        php84-pecl-imap=1.0.3-r0 \
        php84-pecl-mcrypt=1.0.9-r0 \
        php84-pecl-smbclient=1.2.0_pre-r0 \
        php84-phar=8.4.13-r0 \
        php84-posix=8.4.13-r0 \
        php84-session=8.4.13-r0 \
        php84-simplexml=8.4.13-r0 \
        php84-sodium=8.4.13-r0 \
        php84-sqlite3=8.4.13-r0 \
        php84-sysvsem=8.4.13-r0 \
        php84-xml=8.4.13-r0 \
        php84-xmlreader=8.4.13-r0 \
        php84-xmlwriter=8.4.13-r0 \
        php84-zip=8.4.13-r0

ARG PHP_DIR="/etc/php"
ARG INI_CONF="$PHP_DIR/php.ini"
ARG FPM_CONF="$PHP_DIR/php-fpm.conf"
ARG WWW_CONF="$PHP_DIR/php-fpm.d/www.conf"
RUN sed -i "s|^memory_limit[ =].*|memory_limit = 4096M|" "$INI_CONF" && \
    sed -i "s|^;opcache\.enable[ =].*|opcache\.enable = 1|" "$INI_CONF" && \
    sed -i "s|^;opcache\.interned_strings_buffer[ =].*|opcache\.interned_strings_buffer = 8|" "$INI_CONF" && \
    sed -i "s|^;opcache\.max_accelerated_files[ =].*|opcache\.max_accelerated_files = 10000|" "$INI_CONF" && \
    sed -i "s|^;opcache\.memory_consumption[ =].*|opcache\.memory_consumption = 128|" "$INI_CONF" && \
    sed -i "s|^;opcache\.save_comments[ =].*|opcache\.save_comments = 1|" "$INI_CONF" && \
    sed -i "s|^;opcache\.revalidate_freq[ =].*|opcache\.revalidate_freq = 1|" "$INI_CONF" && \
    sed -i "s|^upload_max_filesize[ =].*|upload_max_filesize = 1G|" "$INI_CONF" && \
    sed -i "s|^max_file_uploads[ =].*|max_file_uploads = 512|" "$INI_CONF" && \
    sed -i "s|^post_max_size[ =].*|post_max_size = 1G|" "$INI_CONF" && \
    sed -i "s|^;log_limit[ =].*|log_limit = 16384|" "$FPM_CONF" && \
    sed -i "s|^pm\.max_children[ =].*|pm\.max_children = 32|" "$WWW_CONF"
