FROM hetsh/php82-fpm:8.2.15-1
RUN apk update && \
    apk add --no-cache \
    imagemagick-svg=7.1.1.26-r1 \
    php82-bcmath=8.2.15-r0 \
    php82-bz2=8.2.15-r0 \
    php82-ctype=8.2.15-r0 \
    php82-curl=8.2.15-r0 \
    php82-dom=8.2.15-r0 \
    php82-exif=8.2.15-r0 \
    php82-fileinfo=8.2.15-r0 \
    php82-gd=8.2.15-r0 \
    php82-gmp=8.2.15-r0 \
    php82-iconv=8.2.15-r0 \
    php82-imap=8.2.15-r0 \
    php82-intl=8.2.15-r0 \
    php82-ldap=8.2.15-r0 \
    php82-mbstring=8.2.15-r0 \
    php82-opcache=8.2.15-r0 \
    php82-openssl=8.2.15-r0 \
    php82-pcntl=8.2.15-r0 \
    php82-pdo_mysql=8.2.15-r0 \
    php82-pdo_sqlite=8.2.15-r0 \
    php82-pecl-imagick=3.7.0-r6 \
    php82-pecl-mcrypt=1.0.7-r0 \
    php82-pecl-smbclient=1.1.1-r0 \
    php82-phar=8.2.15-r0 \
    php82-posix=8.2.15-r0 \
    php82-session=8.2.15-r0 \
    php82-simplexml=8.2.15-r0 \
    php82-sodium=8.2.15-r0 \
    php82-sqlite3=8.2.15-r0 \
    php82-sysvsem=8.2.15-r0 \
    php82-xml=8.2.15-r0 \
    php82-xmlreader=8.2.15-r0 \
    php82-xmlwriter=8.2.15-r0 \
    php82-zip=8.2.15-r0

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
