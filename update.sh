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
update_image "hetsh/php83-fpm" "PHP FPM" "true" "(\d+\.)+\d+-\d+"

# Packages
BASE_URL="https://pkgs.alpinelinux.org/package/edge"
PKG_URL="$BASE_URL/community/x86_64"
update_pkg "imagemagick-svg" "ImageMagick SVG Modules" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-bcmath" "PHP BCMATH" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-bz2" "PHP BZ2" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-ctype" "PHP CTYPE" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-curl" "PHP CURL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-dom" "PHP DOM" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-exif" "PHP EXIF" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-fileinfo" "PHP FILEINFO" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-gd" "PHP GD" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-gmp" "PHP GMP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-iconv" "PHP ICONV" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-imap" "PHP IMAP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-intl" "PHP INTL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-ldap" "PHP LDAP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-mbstring" "PHP MBSTRING" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-opcache" "PHP OPCACHE" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-openssl" "PHP OPENSSL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-pcntl" "PHP PCNTL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-pdo_mysql" "PHP PDO (MySQL)" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-pdo_sqlite" "PHP PDO (SQLite)" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-pecl-imagick" "PHP IMAGICK" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-pecl-mcrypt" "PHP MCRYPT" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-pecl-smbclient" "PHP SMBClient" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-phar" "PHP PHAR" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-posix" "PHP POSIX" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-session" "PHP SESSION" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-simplexml" "PHP SIMPLEXML" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-sodium" "PHP Sodium" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-sqlite3" "PHP SQLITE" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-sysvsem" "PHP System V Semaphores" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-xml" "PHP XML" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-xmlreader" "PHP XMLREADER" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-xmlwriter" "PHP XMLWRITER" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php83-zip" "PHP ZIP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"

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
