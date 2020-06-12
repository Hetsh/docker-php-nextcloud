FROM hetsh/php-fpm:7.3.19-1
RUN apk add --no-cache \
    php7=7.3.18-r0 \
    php7-bz2=7.3.19-r0 \
    php7-bcmath=7.3.18-r0 \
    php7-curl=7.3.19-r0 \
    php7-ctype=7.3.18-r0 \
    php7-dom=7.3.18-r0 \
    php7-exif=7.3.19-r0 \
    php7-fileinfo=7.3.18-r0 \
    php7-gd=7.3.19-r0 \
    php7-gmp=7.3.19-r0 \
    php7-iconv=7.3.19-r0 \
    php7-imap=7.3.19-r0 \
    php7-intl=7.3.19-r0 \
    php7-json=7.3.18-r0 \
    php7-ldap=7.3.19-r0 \
    php7-mbstring=7.3.18-r0 \
    php7-opcache=7.3.19-r0 \
    php7-openssl=7.3.18-r0 \
    php7-pcntl=7.3.18-r0 \
    php7-pdo_sqlite=7.3.19-r0 \
    php7-posix=7.3.18-r0 \
    php7-session=7.3.18-r0 \
    php7-simplexml=7.3.18-r0 \
    php7-sqlite3=7.3.19-r0 \
    php7-xml=7.3.18-r0 \
    php7-xmlreader=7.3.18-r0 \
    php7-xmlwriter=7.3.18-r0 \
    php7-zip=7.3.19-r0 \
    php7-pecl-imagick=3.4.4-r3 \
    php7-pecl-mcrypt=1.0.3-r0

ARG PHP_DIR="/etc/php7"
ARG INI_CONF="$PHP_DIR/php.ini"
ARG FPM_CONF="$PHP_DIR/php-fpm.conf"
RUN sed -i "s|^memory_limit.*|memory_limit = 512M|" "$INI_CONF" && \
    sed -i "s|^;opcache.enable.*|opcache.enable=1|" "$INI_CONF" && \
    sed -i "s|^;opcache.interned_strings_buffer.*|opcache.interned_strings_buffer=8|" "$INI_CONF" && \
    sed -i "s|^;opcache.max_accelerated_files.*|opcache.max_accelerated_files=10000|" "$INI_CONF" && \
    sed -i "s|^;opcache.memory_consumption.*|opcache.memory_consumption=128|" "$INI_CONF" && \
    sed -i "s|^;opcache.save_comments.*|opcache.save_comments=1|" "$INI_CONF" && \
    sed -i "s|^;opcache.revalidate_freq.*|opcache.revalidate_freq=1|" "$INI_CONF" && \
    sed -i "s|^;log_limit =.*|log_limit = 16384|" "$FPM_CONF"