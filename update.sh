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
CURRENT_VERSION=$(git describe --tags --abbrev=0)
register_current_version "$CURRENT_VERSION"

# Alpine Linux
IMAGE_PKG="alpine"
IMAGE_NAME="Alpine"
IMAGE_REGEX="(\d+\.)+\d+"
IMAGE_TAGS=$(curl -L -s "https://registry.hub.docker.com/v2/repositories/library/$IMAGE_PKG/tags" | jq '."results"[]["name"]' | grep -P -o "$IMAGE_REGEX")
IMAGE_VERSION=$(echo "$IMAGE_TAGS" | sort --version-sort | tail -n 1)
CURRENT_IMAGE_VERSION=$(cat "Dockerfile" | grep -P -o "FROM $IMAGE_PKG:\K$IMAGE_REGEX")
if [ "$CURRENT_IMAGE_VERSION" != "$IMAGE_VERSION" ]; then
	echo "$IMAGE_NAME $IMAGE_VERSION available!"
	update_release
fi

# PHP-FPM
FPM_PKG="php7-fpm"
FPM_NAME="PHP-FPM"
FPM_REGEX="(\d+\.)+\d+-r\d+"
FPM_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$FPM_PKG" | grep -m 1 -P -o "$FPM_REGEX")
CURRENT_FPM_VERSION=$(cat Dockerfile | grep -P -o "$FPM_PKG=\K$FPM_REGEX")
if [ "$CURRENT_FPM_VERSION" != "$FPM_VERSION" ]; then
	echo "$FPM_NAME $FPM_VERSION available!"

	# Dont update version if only release counter changed
	if [ "${CURRENT_FPM_VERSION%-*}" != "${FPM_VERSION%-*}" ]; then
		update_version "${FPM_VERSION%-*}"
	else
		update_release
	fi
fi

# PHP-BZ2
BZ2_PKG="php7-bz2"
BZ2_NAME="PHP-BZ2"
BZ2_REGEX="(\d+\.)+\d+-r\d+"
BZ2_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$BZ2_PKG" | grep -m 1 -P -o "$BZ2_REGEX")
CURRENT_BZ2_VERSION=$(cat Dockerfile | grep -P -o "$BZ2_PKG=\K$BZ2_REGEX")
if [ "$CURRENT_BZ2_VERSION" != "$BZ2_VERSION" ]; then
	echo "$BZ2_NAME $BZ2_VERSION available!"
	update_release
fi

# PHP-CURL
CURL_PKG="php7-curl"
CURL_NAME="PHP-CURL"
CURL_REGEX="(\d+\.)+\d+-r\d+"
CURL_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$CURL_PKG" | grep -m 1 -P -o "$CURL_REGEX")
CURRENT_CURL_VERSION=$(cat Dockerfile | grep -P -o "$CURL_PKG=\K$CURL_REGEX")
if [ "$CURRENT_CURL_VERSION" != "$CURL_VERSION" ]; then
	echo "$CURL_NAME $CURL_VERSION available!"
	update_release
fi

# PHP-EXIF
EXIF_PKG="php7-exif"
EXIF_NAME="PHP-EXIF"
EXIF_REGEX="(\d+\.)+\d+-r\d+"
EXIF_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$EXIF_PKG" | grep -m 1 -P -o "$EXIF_REGEX")
CURRENT_EXIF_VERSION=$(cat Dockerfile | grep -P -o "$EXIF_PKG=\K$EXIF_REGEX")
if [ "$CURRENT_EXIF_VERSION" != "$EXIF_VERSION" ]; then
	echo "$EXIF_NAME $EXIF_VERSION available!"
	update_release
fi

# PHP-GD
GD_PKG="php7-gd"
GD_NAME="PHP-GD"
GD_REGEX="(\d+\.)+\d+-r\d+"
GD_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$GD_PKG" | grep -m 1 -P -o "$GD_REGEX")
CURRENT_GD_VERSION=$(cat Dockerfile | grep -P -o "$GD_PKG=\K$GD_REGEX")
if [ "$CURRENT_GD_VERSION" != "$GD_VERSION" ]; then
	echo "$GD_NAME $GD_VERSION available!"
	update_release
fi

# PHP-GMP
GMP_PKG="php7-gmp"
GMP_NAME="PHP-GMP"
GMP_REGEX="(\d+\.)+\d+-r\d+"
GMP_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$GMP_PKG" | grep -m 1 -P -o "$GMP_REGEX")
CURRENT_GMP_VERSION=$(cat Dockerfile | grep -P -o "$GMP_PKG=\K$GMP_REGEX")
if [ "$CURRENT_GMP_VERSION" != "$GMP_VERSION" ]; then
	echo "$GMP_NAME $GMP_VERSION available!"
	update_release
fi

# PHP-ICONV
ICONV_PKG="php7-iconv"
ICONV_NAME="PHP-ICONV"
ICONV_REGEX="(\d+\.)+\d+-r\d+"
ICONV_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$ICONV_PKG" | grep -m 1 -P -o "$ICONV_REGEX")
CURRENT_ICONV_VERSION=$(cat Dockerfile | grep -P -o "$ICONV_PKG=\K$ICONV_REGEX")
if [ "$CURRENT_ICONV_VERSION" != "$ICONV_VERSION" ]; then
	echo "$ICONV_NAME $ICONV_VERSION available!"
	update_release
fi

# PHP-IMAP
IMAP_PKG="php7-imap"
IMAP_NAME="PHP-IMAP"
IMAP_REGEX="(\d+\.)+\d+-r\d+"
IMAP_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$IMAP_PKG" | grep -m 1 -P -o "$IMAP_REGEX")
CURRENT_IMAP_VERSION=$(cat Dockerfile | grep -P -o "$IMAP_PKG=\K$IMAP_REGEX")
if [ "$CURRENT_IMAP_VERSION" != "$IMAP_VERSION" ]; then
	echo "$IMAP_NAME $IMAP_VERSION available!"
	update_release
fi

# PHP-INTL
INTL_PKG="php7-intl"
INTL_NAME="PHP-INTL"
INTL_REGEX="(\d+\.)+\d+-r\d+"
INTL_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$INTL_PKG" | grep -m 1 -P -o "$INTL_REGEX")
CURRENT_INTL_VERSION=$(cat Dockerfile | grep -P -o "$INTL_PKG=\K$INTL_REGEX")
if [ "$CURRENT_INTL_VERSION" != "$INTL_VERSION" ]; then
	echo "$INTL_NAME $INTL_VERSION available!"
	update_release
fi

# PHP-LDAP
LDAP_PKG="php7-ldap"
LDAP_NAME="PHP-LDAP"
LDAP_REGEX="(\d+\.)+\d+-r\d+"
LDAP_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$LDAP_PKG" | grep -m 1 -P -o "$LDAP_REGEX")
CURRENT_LDAP_VERSION=$(cat Dockerfile | grep -P -o "$LDAP_PKG=\K$LDAP_REGEX")
if [ "$CURRENT_LDAP_VERSION" != "$LDAP_VERSION" ]; then
	echo "$LDAP_NAME $LDAP_VERSION available!"
	update_release
fi

# PHP-OPCACHE
OPCACHE_PKG="php7-opcache"
OPCACHE_NAME="PHP-OPCACHE"
OPCACHE_REGEX="(\d+\.)+\d+-r\d+"
OPCACHE_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$OPCACHE_PKG" | grep -m 1 -P -o "$OPCACHE_REGEX")
CURRENT_OPCACHE_VERSION=$(cat Dockerfile | grep -P -o "$OPCACHE_PKG=\K$OPCACHE_REGEX")
if [ "$CURRENT_OPCACHE_VERSION" != "$OPCACHE_VERSION" ]; then
	echo "$OPCACHE_NAME $OPCACHE_VERSION available!"
	update_release
fi

# PHP-PDO
PDO_PKG="php7-pdo_sqlite"
PDO_NAME="PHP-PDO"
PDO_REGEX="(\d+\.)+\d+-r\d+"
PDO_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$PDO_PKG" | grep -m 1 -P -o "$PDO_REGEX")
CURRENT_PDO_VERSION=$(cat Dockerfile | grep -P -o "$PDO_PKG=\K$PDO_REGEX")
if [ "$CURRENT_PDO_VERSION" != "$PDO_VERSION" ]; then
	echo "$PDO_NAME $PDO_VERSION available!"
	update_release
fi

# PHP-SQLITE
SQLITE_PKG="php7-sqlite3"
SQLITE_NAME="PHP-SQLITE"
SQLITE_REGEX="(\d+\.)+\d+-r\d+"
SQLITE_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$SQLITE_PKG" | grep -m 1 -P -o "$SQLITE_REGEX")
CURRENT_SQLITE_VERSION=$(cat Dockerfile | grep -P -o "$SQLITE_PKG=\K$SQLITE_REGEX")
if [ "$CURRENT_SQLITE_VERSION" != "$SQLITE_VERSION" ]; then
	echo "$SQLITE_NAME $SQLITE_VERSION available!"
	update_release
fi

# PHP-ZIP
ZIP_PKG="php7-zip"
ZIP_NAME="PHP-ZIP"
ZIP_REGEX="(\d+\.)+\d+-r\d+"
ZIP_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$ZIP_PKG" | grep -m 1 -P -o "$ZIP_REGEX")
CURRENT_ZIP_VERSION=$(cat Dockerfile | grep -P -o "$ZIP_PKG=\K$ZIP_REGEX")
if [ "$CURRENT_ZIP_VERSION" != "$ZIP_VERSION" ]; then
	echo "$ZIP_NAME $ZIP_VERSION available!"
	update_release
fi

# PHP-IMAGICK
IMAGICK_PKG="php7-pecl-imagick"
IMAGICK_NAME="PHP-IMAGICK"
IMAGICK_REGEX="(\d+\.)+\d+-r\d+"
IMAGICK_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$IMAGICK_PKG" | grep -m 1 -P -o "$IMAGICK_REGEX")
CURRENT_IMAGICK_VERSION=$(cat Dockerfile | grep -P -o "$IMAGICK_PKG=\K$IMAGICK_REGEX")
if [ "$CURRENT_IMAGICK_VERSION" != "$IMAGICK_VERSION" ]; then
	echo "$IMAGICK_NAME $IMAGICK_VERSION available!"
	update_release
fi

# PHP-MCRYPT
MCRYPT_PKG="php7-pecl-mcrypt"
MCRYPT_NAME="PHP-MCRYPT"
MCRYPT_REGEX="(\d+\.)+\d+-r\d+"
MCRYPT_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$MCRYPT_PKG" | grep -m 1 -P -o "$MCRYPT_REGEX")
CURRENT_MCRYPT_VERSION=$(cat Dockerfile | grep -P -o "$MCRYPT_PKG=\K$MCRYPT_REGEX")
if [ "$CURRENT_MCRYPT_VERSION" != "$MCRYPT_VERSION" ]; then
	echo "$MCRYPT_NAME $MCRYPT_VERSION available!"
	update_release
fi

if ! updates_available; then
	echo "No updates available."
	exit 0
fi

if [ "${1+}" = "--noconfirm" ] || confirm_action "Save changes?"; then
	if [ "$CURRENT_IMAGE_VERSION" != "$IMAGE_VERSION" ]; then
		sed -i "s|FROM $IMAGE_PKG:$CURRENT_IMAGE_VERSION|FROM $IMAGE_PKG:$IMAGE_VERSION|" Dockerfile
		CHANGELOG+="$IMAGE_NAME $CURRENT_IMAGE_VERSION -> $IMAGE_VERSION, "
	fi

	if [ "$CURRENT_FPM_VERSION" != "$FPM_VERSION" ]; then
		sed -i "s|$FPM_PKG=$CURRENT_FPM_VERSION|$FPM_PKG=$FPM_VERSION|" Dockerfile
		CHANGELOG+="$FPM_NAME $CURRENT_FPM_VERSION -> $FPM_VERSION, "
	fi

	if [ "$CURRENT_BZ2_VERSION" != "$BZ2_VERSION" ]; then
		sed -i "s|$BZ2_PKG=$CURRENT_BZ2_VERSION|$BZ2_PKG=$BZ2_VERSION|" Dockerfile
		CHANGELOG+="$BZ2_NAME $CURRENT_BZ2_VERSION -> $BZ2_VERSION, "
	fi

	if [ "$CURRENT_CURL_VERSION" != "$CURL_VERSION" ]; then
		sed -i "s|$CURL_PKG=$CURRENT_CURL_VERSION|$CURL_PKG=$CURL_VERSION|" Dockerfile
		CHANGELOG+="$CURL_NAME $CURRENT_CURL_VERSION -> $CURL_VERSION, "
	fi

	if [ "$CURRENT_EXIF_VERSION" != "$EXIF_VERSION" ]; then
		sed -i "s|$EXIF_PKG=$CURRENT_EXIF_VERSION|$EXIF_PKG=$EXIF_VERSION|" Dockerfile
		CHANGELOG+="$EXIF_NAME $CURRENT_EXIF_VERSION -> $EXIF_VERSION, "
	fi

	if [ "$CURRENT_GD_VERSION" != "$GD_VERSION" ]; then
		sed -i "s|$GD_PKG=$CURRENT_GD_VERSION|$GD_PKG=$GD_VERSION|" Dockerfile
		CHANGELOG+="$GD_NAME $CURRENT_GD_VERSION -> $GD_VERSION, "
	fi

	if [ "$CURRENT_GMP_VERSION" != "$GMP_VERSION" ]; then
		sed -i "s|$GMP_PKG=$CURRENT_GMP_VERSION|$GMP_PKG=$GMP_VERSION|" Dockerfile
		CHANGELOG+="$GMP_NAME $CURRENT_GMP_VERSION -> $GMP_VERSION, "
	fi

	if [ "$CURRENT_ICONV_VERSION" != "$ICONV_VERSION" ]; then
		sed -i "s|$ICONV_PKG=$CURRENT_ICONV_VERSION|$ICONV_PKG=$ICONV_VERSION|" Dockerfile
		CHANGELOG+="$ICONV_NAME $CURRENT_ICONV_VERSION -> $ICONV_VERSION, "
	fi

	if [ "$CURRENT_IMAP_VERSION" != "$IMAP_VERSION" ]; then
		sed -i "s|$IMAP_PKG=$CURRENT_IMAP_VERSION|$IMAP_PKG=$IMAP_VERSION|" Dockerfile
		CHANGELOG+="$IMAP_NAME $CURRENT_IMAP_VERSION -> $IMAP_VERSION, "
	fi

	if [ "$CURRENT_INTL_VERSION" != "$INTL_VERSION" ]; then
		sed -i "s|$INTL_PKG=$CURRENT_INTL_VERSION|$INTL_PKG=$INTL_VERSION|" Dockerfile
		CHANGELOG+="$INTL_NAME $CURRENT_INTL_VERSION -> $INTL_VERSION, "
	fi

	if [ "$CURRENT_LDAP_VERSION" != "$LDAP_VERSION" ]; then
		sed -i "s|$LDAP_PKG=$CURRENT_LDAP_VERSION|$LDAP_PKG=$LDAP_VERSION|" Dockerfile
		CHANGELOG+="$LDAP_NAME $CURRENT_LDAP_VERSION -> $LDAP_VERSION, "
	fi

	if [ "$CURRENT_OPCACHE_VERSION" != "$OPCACHE_VERSION" ]; then
		sed -i "s|$OPCACHE_PKG=$CURRENT_OPCACHE_VERSION|$OPCACHE_PKG=$OPCACHE_VERSION|" Dockerfile
		CHANGELOG+="$OPCACHE_NAME $CURRENT_OPCACHE_VERSION -> $OPCACHE_VERSION, "
	fi

	if [ "$CURRENT_PDO_VERSION" != "$PDO_VERSION" ]; then
		sed -i "s|$PDO_PKG=$CURRENT_PDO_VERSION|$PDO_PKG=$PDO_VERSION|" Dockerfile
		CHANGELOG+="$PDO_NAME $CURRENT_PDO_VERSION -> $PDO_VERSION, "
	fi

	if [ "$CURRENT_SQLITE_VERSION" != "$SQLITE_VERSION" ]; then
		sed -i "s|$SQLITE_PKG=$CURRENT_SQLITE_VERSION|$SQLITE_PKG=$SQLITE_VERSION|" Dockerfile
		CHANGELOG+="$SQLITE_NAME $CURRENT_SQLITE_VERSION -> $SQLITE_VERSION, "
	fi

	if [ "$CURRENT_ZIP_VERSION" != "$ZIP_VERSION" ]; then
		sed -i "s|$ZIP_PKG=$CURRENT_ZIP_VERSION|$ZIP_PKG=$ZIP_VERSION|" Dockerfile
		CHANGELOG+="$ZIP_NAME $CURRENT_ZIP_VERSION -> $ZIP_VERSION, "
	fi

	if [ "$CURRENT_IMAGICK_VERSION" != "$IMAGICK_VERSION" ]; then
		sed -i "s|$IMAGICK_PKG=$CURRENT_IMAGICK_VERSION|$IMAGICK_PKG=$IMAGICK_VERSION|" Dockerfile
		CHANGELOG+="$IMAGICK_NAME $CURRENT_IMAGICK_VERSION -> $IMAGICK_VERSION, "
	fi

	if [ "$CURRENT_MCRYPT_VERSION" != "$MCRYPT_VERSION" ]; then
		sed -i "s|$MCRYPT_PKG=$CURRENT_MCRYPT_VERSION|$MCRYPT_PKG=$MCRYPT_VERSION|" Dockerfile
		CHANGELOG+="$MCRYPT_NAME $CURRENT_MCRYPT_VERSION -> $MCRYPT_VERSION, "
	fi
	CHANGELOG="${CHANGELOG%,*}"

	if [ "${1+}" = "--noconfirm" ] || confirm_action "Commit changes?"; then
		commit_changes "$CHANGELOG"
	fi
fi
