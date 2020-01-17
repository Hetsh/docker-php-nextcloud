#!/usr/bin/env bash

set -e
trap "exit" SIGINT

if [ "$USER" == "root" ]
then
	echo "Must not be executed as user \"root\"!"
	exit -1
fi

if ! [ -x "$(command -v jq)" ]
then
	echo "JSON Parser \"jq\" is required but not installed!"
	exit -2
fi

if ! [ -x "$(command -v curl)" ]
then
	echo "\"curl\" is required but not installed!"
	exit -3
fi

WORK_DIR="${0%/*}"
cd "$WORK_DIR"

CURRENT_VERSION=$(git describe --tags --abbrev=0)
NEXT_VERSION="$CURRENT_VERSION"

# Base Image
IMAGE_NAME="alpine"
CURRENT_IMAGE_VERSION=$(cat Dockerfile | grep "FROM $IMAGE_NAME:")
CURRENT_IMAGE_VERSION="${CURRENT_IMAGE_VERSION#*:}"
IMAGE_VERSION=$(curl -L -s "https://registry.hub.docker.com/v2/repositories/library/$IMAGE_NAME/tags" | jq '."results"[]["name"]' | grep -m 1 -P -o "(\d+\.)+\d+")
if [ "$CURRENT_IMAGE_VERSION" != "$IMAGE_VERSION" ]
then
	echo "Alpine $IMAGE_VERSION available!"

	RELEASE="${CURRENT_VERSION#*-}"
	NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
fi

# PHP-FPM
FPM_PKG="php7-fpm"
CURRENT_FPM_VERSION=$(cat Dockerfile | grep -P -o "$FPM_PKG=\K(\d+\.)+\d+-r\d+")
FPM_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$FPM_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_FPM_VERSION" != "$FPM_VERSION" ]
then
	echo "PHP-FPM $FPM_VERSION available!"

	if [ "${CURRENT_FPM_VERSION%-*}" != "${FPM_VERSION%-*}" ]
	then
		NEXT_VERSION="${FPM_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

# PHP-BZ2
BZ2_PKG="php7-bz2"
CURRENT_BZ2_VERSION=$(cat Dockerfile | grep -P -o "$BZ2_PKG=\K(\d+\.)+\d+-r\d+")
BZ2_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$BZ2_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_BZ2_VERSION" != "$BZ2_VERSION" ]
then
	echo "PHP-BZ2 $BZ2_VERSION available!"

	if [ "${CURRENT_BZ2_VERSION%-*}" != "${BZ2_VERSION%-*}" ]
	then
		NEXT_VERSION="${BZ2_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

# PHP-CURL
CURL_PKG="php7-curl"
CURRENT_CURL_VERSION=$(cat Dockerfile | grep -P -o "$CURL_PKG=\K(\d+\.)+\d+-r\d+")
CURL_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$CURL_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_CURL_VERSION" != "$CURL_VERSION" ]
then
	echo "PHP-CURL $CURL_VERSION available!"

	if [ "${CURRENT_CURL_VERSION%-*}" != "${CURL_VERSION%-*}" ]
	then
		NEXT_VERSION="${CURL_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

# PHP-EXIF
EXIF_PKG="php7-exif"
CURRENT_EXIF_VERSION=$(cat Dockerfile | grep -P -o "$EXIF_PKG=\K(\d+\.)+\d+-r\d+")
EXIF_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$EXIF_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_EXIF_VERSION" != "$EXIF_VERSION" ]
then
	echo "PHP-EXIF $EXIF_VERSION available!"

	if [ "${CURRENT_EXIF_VERSION%-*}" != "${EXIF_VERSION%-*}" ]
	then
		NEXT_VERSION="${EXIF_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

# PHP-GD
GD_PKG="php7-gd"
CURRENT_GD_VERSION=$(cat Dockerfile | grep -P -o "$GD_PKG=\K(\d+\.)+\d+-r\d+")
GD_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$GD_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_GD_VERSION" != "$GD_VERSION" ]
then
	echo "PHP-GD $GD_VERSION available!"

	if [ "${CURRENT_GD_VERSION%-*}" != "${GD_VERSION%-*}" ]
	then
		NEXT_VERSION="${GD_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

# PHP-GMP
GMP_PKG="php7-gmp"
CURRENT_GMP_VERSION=$(cat Dockerfile | grep -P -o "$GMP_PKG=\K(\d+\.)+\d+-r\d+")
GMP_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$GMP_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_GMP_VERSION" != "$GMP_VERSION" ]
then
	echo "PHP-GMP $GMP_VERSION available!"

	if [ "${CURRENT_GMP_VERSION%-*}" != "${GMP_VERSION%-*}" ]
	then
		NEXT_VERSION="${GMP_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

# PHP-ICONV
ICONV_PKG="php7-iconv"
CURRENT_ICONV_VERSION=$(cat Dockerfile | grep -P -o "$ICONV_PKG=\K(\d+\.)+\d+-r\d+")
ICONV_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$ICONV_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_ICONV_VERSION" != "$ICONV_VERSION" ]
then
	echo "PHP-ICONV $ICONV_VERSION available!"

	if [ "${CURRENT_ICONV_VERSION%-*}" != "${ICONV_VERSION%-*}" ]
	then
		NEXT_VERSION="${ICONV_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

# PHP-IMAP
IMAP_PKG="php7-imap"
CURRENT_IMAP_VERSION=$(cat Dockerfile | grep -P -o "$IMAP_PKG=\K(\d+\.)+\d+-r\d+")
IMAP_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$IMAP_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_IMAP_VERSION" != "$IMAP_VERSION" ]
then
	echo "PHP-IMAP $IMAP_VERSION available!"

	if [ "${CURRENT_IMAP_VERSION%-*}" != "${IMAP_VERSION%-*}" ]
	then
		NEXT_VERSION="${IMAP_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

# PHP-INTL
INTL_PKG="php7-intl"
CURRENT_INTL_VERSION=$(cat Dockerfile | grep -P -o "$INTL_PKG=\K(\d+\.)+\d+-r\d+")
INTL_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$INTL_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_INTL_VERSION" != "$INTL_VERSION" ]
then
	echo "PHP-INTL $INTL_VERSION available!"

	if [ "${CURRENT_INTL_VERSION%-*}" != "${INTL_VERSION%-*}" ]
	then
		NEXT_VERSION="${INTL_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

# PHP-LDAP
LDAP_PKG="php7-ldap"
CURRENT_LDAP_VERSION=$(cat Dockerfile | grep -P -o "$LDAP_PKG=\K(\d+\.)+\d+-r\d+")
LDAP_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$LDAP_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_LDAP_VERSION" != "$LDAP_VERSION" ]
then
	echo "PHP-LDAP $LDAP_VERSION available!"

	if [ "${CURRENT_LDAP_VERSION%-*}" != "${LDAP_VERSION%-*}" ]
	then
		NEXT_VERSION="${LDAP_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

# PHP-OPCACHE
OPCACHE_PKG="php7-opcache"
CURRENT_OPCACHE_VERSION=$(cat Dockerfile | grep -P -o "$OPCACHE_PKG=\K(\d+\.)+\d+-r\d+")
OPCACHE_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$OPCACHE_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_OPCACHE_VERSION" != "$OPCACHE_VERSION" ]
then
	echo "PHP-OPCACHE $OPCACHE_VERSION available!"

	if [ "${CURRENT_OPCACHE_VERSION%-*}" != "${OPCACHE_VERSION%-*}" ]
	then
		NEXT_VERSION="${OPCACHE_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

# PHP-PDO
PDO_PKG="php7-pdo_sqlite"
CURRENT_PDO_VERSION=$(cat Dockerfile | grep -P -o "$PDO_PKG=\K(\d+\.)+\d+-r\d+")
PDO_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$PDO_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_PDO_VERSION" != "$PDO_VERSION" ]
then
	echo "PHP-PDO $PDO_VERSION available!"

	if [ "${CURRENT_PDO_VERSION%-*}" != "${PDO_VERSION%-*}" ]
	then
		NEXT_VERSION="${PDO_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

# PHP-SQLITE
SQLITE_PKG="php7-sqlite3"
CURRENT_SQLITE_VERSION=$(cat Dockerfile | grep -P -o "$SQLITE_PKG=\K(\d+\.)+\d+-r\d+")
SQLITE_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$SQLITE_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_SQLITE_VERSION" != "$SQLITE_VERSION" ]
then
	echo "PHP-SQLITE $SQLITE_VERSION available!"

	if [ "${CURRENT_SQLITE_VERSION%-*}" != "${SQLITE_VERSION%-*}" ]
	then
		NEXT_VERSION="${SQLITE_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

# PHP-ZIP
ZIP_PKG="php7-zip"
CURRENT_ZIP_VERSION=$(cat Dockerfile | grep -P -o "$ZIP_PKG=\K(\d+\.)+\d+-r\d+")
ZIP_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$ZIP_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_ZIP_VERSION" != "$ZIP_VERSION" ]
then
	echo "PHP-ZIP $ZIP_VERSION available!"

	if [ "${CURRENT_ZIP_VERSION%-*}" != "${ZIP_VERSION%-*}" ]
	then
		NEXT_VERSION="${ZIP_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

# PHP-IMAGICK
IMAGICK_PKG="php7-pecl-imagick"
CURRENT_IMAGICK_VERSION=$(cat Dockerfile | grep -P -o "$IMAGICK_PKG=\K(\d+\.)+\d+-r\d+")
IMAGICK_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$IMAGICK_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_IMAGICK_VERSION" != "$IMAGICK_VERSION" ]
then
	echo "PHP-IMAGICK $IMAGICK_VERSION available!"

	if [ "${CURRENT_IMAGICK_VERSION%-*}" != "${IMAGICK_VERSION%-*}" ]
	then
		NEXT_VERSION="${IMAGICK_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

# PHP-MCRYPT
MCRYPT_PKG="php7-pecl-mcrypt"
CURRENT_MCRYPT_VERSION=$(cat Dockerfile | grep -P -o "$MCRYPT_PKG=\K(\d+\.)+\d+-r\d+")
MCRYPT_VERSION=$(curl -L -s "https://pkgs.alpinelinux.org/package/v${IMAGE_VERSION%.*}/community/x86_64/$MCRYPT_PKG" | grep -m 1 -P -o "(\d+\.)+\d+-r\d+")
if [ "$CURRENT_MCRYPT_VERSION" != "$MCRYPT_VERSION" ]
then
	echo "PHP-MCRYPT $MCRYPT_VERSION available!"

	if [ "${CURRENT_MCRYPT_VERSION%-*}" != "${MCRYPT_VERSION%-*}" ]
	then
		NEXT_VERSION="${MCRYPT_VERSION%-*}-1"
	else
		RELEASE="${CURRENT_VERSION#*-}"
		NEXT_VERSION="${CURRENT_VERSION%-*}-$((RELEASE+1))"
	fi
fi

if [ "$CURRENT_VERSION" == "$NEXT_VERSION" ]
then
	echo "No updates available."
else
	if [ "$1" == "--noconfirm" ]
	then
		SAVE="y"
	else
		read -p "Save changes? [y/n]" -n 1 -r SAVE && echo
	fi
	
	if [[ $SAVE =~ ^[Yy]$ ]]
	then
		if [ "$CURRENT_ALPINE_VERSION" != "$ALPINE_VERSION" ]
		then
			sed -i "s|FROM $IMAGE_NAME:.*|FROM $IMAGE_NAME:$ALPINE_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_FPM_VERSION" != "$FPM_VERSION" ]
		then
			sed -i "s|$FPM_PKG=.*|$FPM_PKG=$FPM_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_BZ2_VERSION" != "$BZ2_VERSION" ]
		then
			sed -i "s|$BZ2_PKG=.*|$BZ2_PKG=$BZ2_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_CURL_VERSION" != "$CURL_VERSION" ]
		then
			sed -i "s|$CURL_PKG=.*|$CURL_PKG=$CURL_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_EXIF_VERSION" != "$EXIF_VERSION" ]
		then
			sed -i "s|$EXIF_PKG=.*|$EXIF_PKG=$EXIF_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_GD_VERSION" != "$GD_VERSION" ]
		then
			sed -i "s|$GD_PKG=.*|$GD_PKG=$GD_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_GMP_VERSION" != "$GMP_VERSION" ]
		then
			sed -i "s|$GMP_PKG=.*|$GMP_PKG=$GMP_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_ICONV_VERSION" != "$ICONV_VERSION" ]
		then
			sed -i "s|$ICONV_PKG=.*|$ICONV_PKG=$ICONV_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_IMAP_VERSION" != "$IMAP_VERSION" ]
		then
			sed -i "s|$IMAP_PKG=.*|$IMAP_PKG=$IMAP_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_INTL_VERSION" != "$INTL_VERSION" ]
		then
			sed -i "s|$INTL_PKG=.*|$INTL_PKG=$INTL_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_LDAP_VERSION" != "$LDAP_VERSION" ]
		then
			sed -i "s|$LDAP_PKG=.*|$LDAP_PKG=$LDAP_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_OPCACHE_VERSION" != "$OPCACHE_VERSION" ]
		then
			sed -i "s|$OPCACHE_PKG=.*|$OPCACHE_PKG=$OPCACHE_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_PDO_VERSION" != "$PDO_VERSION" ]
		then
			sed -i "s|$PDO_PKG=.*|$PDO_PKG=$PDO_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_SQLITE_VERSION" != "$SQLITE_VERSION" ]
		then
			sed -i "s|$SQLITE_PKG=.*|$SQLITE_PKG=$SQLITE_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_ZIP_VERSION" != "$ZIP_VERSION" ]
		then
			sed -i "s|$ZIP_PKG=.*|$ZIP_PKG=$ZIP_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_IMAGICK_VERSION" != "$IMAGICK_VERSION" ]
		then
			sed -i "s|$IMAGICK_PKG=.*|$IMAGICK_PKG=$IMAGICK_VERSION|" Dockerfile
		fi

		if [ "$CURRENT_MCRYPT_VERSION" != "$MCRYPT_VERSION" ]
		then
			sed -i "s|$MCRYPT_PKG=.*|$MCRYPT_PKG=$MCRYPT_VERSION|" Dockerfile
		fi

		if [ "$1" == "--noconfirm" ]
		then
			COMMIT="y"
		else
			read -p "Commit changes? [y/n]" -n 1 -r COMMIT && echo
		fi

		if [[ $COMMIT =~ ^[Yy]$ ]]
		then
			git add Dockerfile
			git commit -m "Version bump to $NEXT_VERSION"
			git push
			git tag "$NEXT_VERSION"
			git push origin "$NEXT_VERSION"
		fi
	fi
fi
