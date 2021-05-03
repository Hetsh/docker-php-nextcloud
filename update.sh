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

# Alpine Linux with PHP8-FPM
update_image "hetsh/php8-fpm" "PHP8 FPM" "true" "(\d+\.)+\d+-\d+"

# Packages
PKG_URL="https://pkgs.alpinelinux.org/package/edge/community/x86_64"
update_pkg "php8-bz2" "PHP8 BZ2" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-bcmath" "PHP8 BCMATH" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-curl" "PHP8 CURL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-ctype" "PHP8 CTYPE" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-dom" "PHP8 DOM" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-exif" "PHP8 EXIF" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-fileinfo" "PHP8 FILEINFO" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-gd" "PHP8 GD" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-gmp" "PHP8 GMP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-iconv" "PHP8 ICONV" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-imap" "PHP8 IMAP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-intl" "PHP8 INTL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-ldap" "PHP8 LDAP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-mbstring" "PHP8 MBSTRING" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-opcache" "PHP8 OPCACHE" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-openssl" "PHP8 OPENSSL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-pcntl" "PHP8 PCNTL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-pdo_sqlite" "PHP8 PDO" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-pdo_mysql" "PHP8 PDO" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-posix" "PHP8 POSIX" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-session" "PHP8 SESSION" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-simplexml" "PHP8 SIMPLEXML" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-sqlite3" "PHP8 SQLITE" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-xml" "PHP8 XML" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-xmlreader" "PHP8 XMLREADER" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-xmlwriter" "PHP8 XMLWRITER" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-zip" "PHP8 ZIP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-pecl-imagick" "PHP8 IMAGICK" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php8-pecl-mcrypt" "PHP8 MCRYPT" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"

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
