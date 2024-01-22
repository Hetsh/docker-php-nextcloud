#!/usr/bin/env bash


# Abort on any error
set -e -u

# Simpler git usage, relative file paths
CWD=$(dirname "$0")
cd "$CWD"

# Load helpful functions
source libs/common.sh
source libs/docker.sh

# Check dependencies
assert_dependency "jq"
assert_dependency "curl"

# Alpine Linux with .1-FPM
update_image "hetsh/php82-fpm" "PHP FPM" "true" "(\d+\.)+\d+-\d+"

# Packages
BASE_URL="https://pkgs.alpinelinux.org/package/edge"
PKG_URL="$BASE_URL/community/x86_64"
update_pkg "imagemagick-svg" "ImageMagick SVG Modules" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-bcmath" "PHP BCMATH" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-bz2" "PHP BZ2" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-ctype" "PHP CTYPE" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-curl" "PHP CURL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-dom" "PHP DOM" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-exif" "PHP EXIF" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-fileinfo" "PHP FILEINFO" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-gd" "PHP GD" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-gmp" "PHP GMP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-iconv" "PHP ICONV" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-imap" "PHP IMAP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-intl" "PHP INTL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-ldap" "PHP LDAP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-mbstring" "PHP MBSTRING" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-opcache" "PHP OPCACHE" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-openssl" "PHP OPENSSL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-pcntl" "PHP PCNTL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-pdo_mysql" "PHP PDO" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-pdo_sqlite" "PHP PDO" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-pecl-imagick" "PHP IMAGICK" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-pecl-mcrypt" "PHP MCRYPT" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-pecl-smbclient" "PHP SMBClient" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-phar" "PHP PHAR" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-posix" "PHP POSIX" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-session" "PHP SESSION" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-simplexml" "PHP SIMPLEXML" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-sodium" "PHP Sodium" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-sqlite3" "PHP SQLITE" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-sysvsem" "PHP System V Semaphores" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-xml" "PHP XML" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-xmlreader" "PHP XMLREADER" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-xmlwriter" "PHP XMLWRITER" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php82-zip" "PHP ZIP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"

if ! updates_available; then
	#echo "No updates available."
	exit 0
fi

# Perform modifications
if [ "${1-}" = "--noconfirm" ] || confirm_action "Save changes?"; then
	save_changes

	if [ "${1-}" = "--noconfirm" ] || confirm_action "Commit changes?"; then
		commit_changes
	fi
fi
