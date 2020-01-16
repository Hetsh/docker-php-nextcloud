#!/usr/bin/env bash

set -e
trap "exit" SIGINT

if ! docker version &> /dev/null
then
	echo "Docker daemon is not running or you have unsufficient permissions!"
	exit -1
fi

WORK_DIR="${0%/*}"
cd "$WORK_DIR"

APP_NAME="php-fpm"
docker build --tag "$APP_NAME" .

read -p "Test image? [y/n]" -n 1 -r && echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	docker run \
	--rm \
	--interactive \
	--publish 9000:9000/tcp \
	--name "$APP_NAME" \
	"$APP_NAME"
fi
