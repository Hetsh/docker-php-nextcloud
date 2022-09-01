FROM hetsh/php8-fpm:8.0.22-1
RUN apk add --no-cache \
        php8-bz2=8.0.23-r0 \
        php8-bcmath=8.0.23-r0 \
        php8-curl=8.0.23-r0 \
        php8-ctype=8.0.23-r0 \
        php8-dom=8.0.23-r0 \
        php8-exif=8.0.23-r0 \
        php8-fileinfo=8.0.23-r0 \
        php8-gd=8.0.23-r0 \
        php8-gmp=8.0.23-r0 \
        php8-iconv=8.0.23-r0 \
        php8-imap=8.0.23-r0 \
        php8-intl=8.0.23-r0 \
        php8-ldap=8.0.23-r0 \
        php8-mbstring=8.0.23-r0 \
        php8-opcache=8.0.23-r0 \
        php8-openssl=8.0.23-r0 \
        php8-pcntl=8.0.23-r0 \
        php8-pdo_sqlite=8.0.23-r0 \
        php8-pdo_mysql=8.0.23-r0 \
        php8-posix=8.0.23-r0 \
        php8-session=8.0.23-r0 \
        php8-simplexml=8.0.23-r0 \
        php8-sqlite3=8.0.23-r0 \
        php8-xml=8.0.23-r0 \
        php8-xmlreader=8.0.23-r0 \
        php8-xmlwriter=8.0.23-r0 \
        php8-zip=8.0.23-r0 \
        php8-pecl-imagick=3.7.0-r0 \
        php8-pecl-mcrypt=1.0.5-r0

ARG PHP_DIR="/etc/php8"
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
