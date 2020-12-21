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

# Alpine Linux with PHP7-FPM
update_image "hetsh/php7-fpm" "PHP7 FPM" "true" "(\d+\.)+\d+-\d+"

# Packages
PKG_URL="https://pkgs.alpinelinux.org/package/edge/community/x86_64"
update_pkg "php7-bz2" "PHP7 BZ2" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-bcmath" "PHP7 BCMATH" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-curl" "PHP7 CURL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-ctype" "PHP7 CTYPE" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-dom" "PHP7 DOM" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-exif" "PHP7 EXIF" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-fileinfo" "PHP7 FILEINFO" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-gd" "PHP7 GD" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-gmp" "PHP7 GMP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-iconv" "PHP7 ICONV" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-imap" "PHP7 IMAP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-intl" "PHP7 INTL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-json" "PHP7 JSON" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-ldap" "PHP7 LDAP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-mbstring" "PHP7 MBSTRING" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-opcache" "PHP7 OPCACHE" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-openssl" "PHP7 OPENSSL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-pcntl" "PHP7 PCNTL" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-pdo_sqlite" "PHP7 PDO" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-pdo_mysql" "PHP7 PDO" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-posix" "PHP7 POSIX" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-session" "PHP7 SESSION" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-simplexml" "PHP7 SIMPLEXML" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-sqlite3" "PHP7 SQLITE" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-xml" "PHP7 XML" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-xmlreader" "PHP7 XMLREADER" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-xmlwriter" "PHP7 XMLWRITER" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-zip" "PHP7 ZIP" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-pecl-imagick" "PHP7 IMAGICK" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php7-pecl-mcrypt" "PHP7 MCRYPT" "false" "$PKG_URL" "(\d+\.)+\d+-r\d+"

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
