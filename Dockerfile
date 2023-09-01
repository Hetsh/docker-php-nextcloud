FROM hetsh/php81-fpm:8.1.23-2
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
	apk update && \
	apk add --no-cache \
        php81-bz2=8.1.23-r0 \
        php81-bcmath=8.1.23-r0 \
        php81-curl=8.1.23-r0 \
        php81-ctype=8.1.23-r0 \
        php81-dom=8.1.23-r0 \
        php81-exif=8.1.23-r0 \
        php81-fileinfo=8.1.23-r0 \
        php81-gd=8.1.23-r0 \
        php81-gmp=8.1.23-r0 \
        php81-iconv=8.1.23-r0 \
        php81-imap=8.1.23-r0 \
        php81-intl=8.1.23-r0 \
        php81-ldap=8.1.23-r0 \
        php81-mbstring=8.1.23-r0 \
        php81-opcache=8.1.23-r0 \
        php81-openssl=8.1.23-r0 \
        php81-pcntl=8.1.23-r0 \
        php81-pdo_sqlite=8.1.23-r0 \
        php81-pdo_mysql=8.1.23-r0 \
        php81-posix=8.1.23-r0 \
        php81-session=8.1.23-r0 \
        php81-simplexml=8.1.23-r0 \
        php81-sqlite3=8.1.23-r0 \
        php81-xml=8.1.23-r0 \
        php81-xmlreader=8.1.23-r0 \
        php81-xmlwriter=8.1.23-r0 \
        php81-zip=8.1.23-r0 \
        php81-pecl-imagick=3.7.0-r4 \
        php81-pecl-mcrypt=1.0.6-r0 \
        php81-pecl-smbclient=1.1.1-r1

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
