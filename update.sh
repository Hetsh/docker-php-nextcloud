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

# Alpine Linux with PHP-FPM
update_image "hetsh/php-fpm" "PHP-FPM" "true" "(\d+\.)+\d+-\d+"

# Packages
PKG_URL="https://pkgs.alpinelinux.org/package/edge/community/x86_64"
update_pkg "php7-bz2" "PHP-BZ2" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-bcmath" "PHP-BCMATH" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-curl" "PHP-CURL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-ctype" "PHP-CTYPE" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-dom" "PHP-DOM" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-exif" "PHP-EXIF" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-fileinfo" "PHP-FILEINFO" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-gd" "PHP-GD" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-gmp" "PHP-GMP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-iconv" "PHP-ICONV" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-imap" "PHP-IMAP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-intl" "PHP-INTL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-json" "PHP-JSON" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-ldap" "PHP-LDAP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-mbstring" "PHP-MBSTRING" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-opcache" "PHP-OPCACHE" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-openssl" "PHP-OPENSSL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-pcntl" "PHP-PCNTL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-pdo_sqlite" "PHP-PDO" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-posix" "PHP-POSIX" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-session" "PHP-SESSION" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-simplexml" "PHP-SIMPLEXML" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-sqlite3" "PHP-SQLITE" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-xml" "PHP-XML" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-xmlreader" "PHP-XMLREADER" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-xmlwriter" "PHP-XMLWRITER" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-zip" "PHP-ZIP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-pecl-imagick" "PHP-IMAGICK" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-pecl-mcrypt" "PHP-MCRYPT" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"

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