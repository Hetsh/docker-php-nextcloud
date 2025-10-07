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
update_image "hetsh/php84-fpm" "PHP FPM" "true" "(\d+\.)+\d+-\d+"

# Packages
BASE_URL="https://pkgs.alpinelinux.org/package/edge"
COMMUNITY_URL="$BASE_URL/community/x86_64"
update_pkg "imagemagick-svg" "ImageMagick SVG Modules" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-bcmath" "PHP BCMATH" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-bz2" "PHP BZ2" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-ctype" "PHP CTYPE" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-curl" "PHP CURL" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-dom" "PHP DOM" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-exif" "PHP EXIF" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-fileinfo" "PHP FILEINFO" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-gd" "PHP GD" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-gmp" "PHP GMP" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-iconv" "PHP ICONV" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-intl" "PHP INTL" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-ldap" "PHP LDAP" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-mbstring" "PHP MBSTRING" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-opcache" "PHP OPCACHE" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-openssl" "PHP OPENSSL" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-pcntl" "PHP PCNTL" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-pdo_mysql" "PHP PDO (MySQL)" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-pdo_sqlite" "PHP PDO (SQLite)" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-pecl-imagick" "PHP IMAGICK" "false" "$COMMUNITY_URL" "(\d+\.)+\d+(_rc\d+)?-r\d+"
update_pkg "php84-pecl-imap" "PHP IMAP" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-pecl-mcrypt" "PHP MCRYPT" "false" "$BASE_URL/testing/x86_64" "(\d+\.)+\d+-r\d+"
update_pkg "php84-pecl-smbclient" "PHP SMBClient" "false" "$COMMUNITY_URL" "(\d+\.)+\d+(_pre)?-r\d+"
update_pkg "php84-phar" "PHP PHAR" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-posix" "PHP POSIX" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-session" "PHP SESSION" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-simplexml" "PHP SIMPLEXML" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-sodium" "PHP Sodium" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-sqlite3" "PHP SQLITE" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-sysvsem" "PHP System V Semaphores" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-xml" "PHP XML" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-xmlreader" "PHP XMLREADER" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-xmlwriter" "PHP XMLWRITER" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"
update_pkg "php84-zip" "PHP ZIP" "false" "$COMMUNITY_URL" "(\d+\.)+\d+-r\d+"

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
