#!/usr/bin/env bash


# Abort on any error
set -eu

# Simpler git usage, relative file paths
CWD=$(dirname "$0")
cd "$CWD"

# Load helpful functions
source libs/common.sh
source libs/docker.sh

# Check dependencies
assert_dependency "jq"
assert_dependency "curl"

# Current version of docker image
register_current_version

# Alpine Linux
update_image "alpine" "Alpine" "x86_64" "(\d+\.)+\d+"

# PHP
update_alpine_pkg "php7-fpm" "PHP-FPM" "true" "community" "(\d+\.)+\d+-r\d+"
update_alpine_pkg "php7-bz2" "PHP-BZ2" "false" "community" "(\d+\.)+\d+-r\d+"
update_alpine_pkg "php7-curl" "PHP-CURL" "false" "community" "(\d+\.)+\d+-r\d+"
update_alpine_pkg "php7-exif" "PHP-EXIF" "false" "community" "(\d+\.)+\d+-r\d+"
update_alpine_pkg "php7-gd" "PHP-GD" "false" "community" "(\d+\.)+\d+-r\d+"
update_alpine_pkg "php7-gmp" "PHP-GMP" "false" "community" "(\d+\.)+\d+-r\d+"
update_alpine_pkg "php7-iconv" "PHP-ICONV" "false" "community" "(\d+\.)+\d+-r\d+"
update_alpine_pkg "php7-imap" "PHP-IMAP" "false" "community" "(\d+\.)+\d+-r\d+"
update_alpine_pkg "php7-intl" "PHP-INTL" "false" "community" "(\d+\.)+\d+-r\d+"
update_alpine_pkg "php7-ldap" "PHP-LDAP" "false" "community" "(\d+\.)+\d+-r\d+"
update_alpine_pkg "php7-opcache" "PHP-OPCACHE" "false" "community" "(\d+\.)+\d+-r\d+"
update_alpine_pkg "php7-pdo_sqlite" "PHP-PDO" "false" "community" "(\d+\.)+\d+-r\d+"
update_alpine_pkg "php7-sqlite3" "PHP-SQLITE" "false" "community" "(\d+\.)+\d+-r\d+"
update_alpine_pkg "php7-zip" "PHP-ZIP" "false" "community" "(\d+\.)+\d+-r\d+"
update_alpine_pkg "php7-pecl-imagick" "PHP-IMAGICK" "false" "community" "(\d+\.)+\d+-r\d+"
update_alpine_pkg "php7-pecl-mcrypt" "PHP-MCRYPT" "false" "community" "(\d+\.)+\d+-r\d+"

if ! updates_available; then
	echo "No updates available."
	exit 0
fi

# Perform modifications
if [ "${1+}" = "--noconfirm" ] || confirm_action "Save changes?"; then
	save_changes

	if [ "${1+}" = "--noconfirm" ] || confirm_action "Commit changes?"; then
		commit_changes
	fi
fi