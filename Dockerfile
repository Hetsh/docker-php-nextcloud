FROM hetsh/php85-fpm:8.5.8-1
ARG LAST_UPGRADE="2026-07-12T06:49:32+02:00"
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
	apk upgrade --no-cache && \
	apk add --no-cache \
		imagemagick-svg=7.1.2.25-r0 \
		php85-bcmath=8.5.8-r0 \
		php85-bz2=8.5.8-r0 \
		php85-ctype=8.5.8-r0 \
		php85-curl=8.5.8-r0 \
		php85-dom=8.5.8-r0 \
		php85-exif=8.5.8-r0 \
		php85-fileinfo=8.5.8-r0 \
		php85-gd=8.5.8-r0 \
		php85-gmp=8.5.8-r0 \
		php85-iconv=8.5.8-r0 \
		php85-intl=8.5.8-r0 \
		php85-ldap=8.5.8-r0 \
		php85-mbstring=8.5.8-r0 \
		php85-openssl=8.5.8-r0 \
		php85-pcntl=8.5.8-r0 \
		php85-pdo_mysql=8.5.8-r0 \
		php85-pdo_sqlite=8.5.8-r0 \
		php85-pecl-imagick=3.8.1-r0 \
		php85-pecl-imap=1.0.3-r0 \
		php85-pecl-smbclient=1.2.0_pre-r0 \
		php85-phar=8.5.8-r0 \
		php85-posix=8.5.8-r0 \
		php85-session=8.5.8-r0 \
		php85-simplexml=8.5.8-r0 \
		php85-sodium=8.5.8-r0 \
		php85-sqlite3=8.5.8-r0 \
		php85-sysvsem=8.5.8-r0 \
		php85-xml=8.5.8-r0 \
		php85-xmlreader=8.5.8-r0 \
		php85-xmlwriter=8.5.8-r0 \
		php85-zip=8.5.8-r0

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
