#!/bin/bash
# shellcheck disable=SC2034

# This file will be sourced by scripts/update.sh to customize the update process


MAIN_ITEM="hetsh/php84-fpm"
GIT_VERSION="$(git describe --tags --first-parent --abbrev=0)"
update_image "$MAIN_ITEM" "(\d+\.)+\d+-\d+" "PHP FPM"
update_packages_apk "hetsh/php-nextcloud"
