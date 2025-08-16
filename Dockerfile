FROM hetsh/php83-fpm:8.3.24-1
RUN apk update && \
    apk add --no-cache \
    imagemagick-svg=7.1.2.1-r0 \
    php83-bcmath=8.3.24-r0 \
    php83-bz2=8.3.24-r0 \
    php83-ctype=8.3.24-r0 \
    php83-curl=8.3.24-r0 \
    php83-dom=8.3.24-r0 \
    php83-exif=8.3.24-r0 \
    php83-fileinfo=8.3.24-r0 \
    php83-gd=8.3.24-r0 \
    php83-gmp=8.3.24-r0 \
    php83-iconv=8.3.24-r0 \
    php83-imap=8.3.24-r0 \
    php83-intl=8.3.24-r0 \
    php83-ldap=8.3.24-r0 \
    php83-mbstring=8.3.24-r0 \
    php83-opcache=8.3.24-r0 \
    php83-openssl=8.3.24-r0 \
    php83-pcntl=8.3.24-r0 \
    php83-pdo_mysql=8.3.24-r0 \
    php83-pdo_sqlite=8.3.24-r0 \
    php83-pecl-imagick=3.8.0-r1 \
    php83-pecl-mcrypt=1.0.9-r0 \
    php83-pecl-smbclient=1.2.0_pre-r0 \
    php83-phar=8.3.24-r0 \
    php83-posix=8.3.24-r0 \
    php83-session=8.3.24-r0 \
    php83-simplexml=8.3.24-r0 \
    php83-sodium=8.3.24-r0 \
    php83-sqlite3=8.3.24-r0 \
    php83-sysvsem=8.3.24-r0 \
    php83-xml=8.3.24-r0 \
    php83-xmlreader=8.3.24-r0 \
    php83-xmlwriter=8.3.24-r0 \
    php83-zip=8.3.24-r0

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
