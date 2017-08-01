#!/usr/bin/env bash

# fail immediately
set -e
set -o pipefail

APPNAME="hostname"

ALPHA_LINUX_NAME="$APPNAME-linux_amd64-alpha"
ALPHA_MACOS_NAME="$APPNAME-macos_amd64-alpha"
ALPHA_WIN_NAME="$APPNAME-windows_amd64-alpha.exe"

ALPHA_IMAGE="slintes/${APPNAME}:alpha"

# save where we are coming from, that's where our sources are
SRCDIR=`pwd`

# create correct golang dir structure for this project
#echo "Creating directory structure"
PACKAGE_PATH="${GOPATH}/src/github.com/slintes/${APPNAME}"
#mkdir -p "${PACKAGE_PATH}"

# copy sources to new directory
#echo "Copying sources"
#cd "${SRCDIR}"
#tar -cO --exclude .git . | tar -xv -C "${PACKAGE_PATH}"

# build binaries
echo "Building binaries"
cd "${PACKAGE_PATH}"

CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o "$ALPHA_LINUX_NAME" .
CGO_ENABLED=0 GOOS=darwin go build -a -installsuffix cgo -o "$ALPHA_MACOS_NAME" .
#CGO_ENABLED=0 GOOS=windows go build -a -installsuffix cgo -o "$ALPHA_WIN_NAME" .

echo "Build successful"

echo "Building alpha docker image"
cp "$ALPHA_LINUX_NAME" "$APPNAME"
docker build -t "$ALPHA_IMAGE" .
#echo "Tagging hashed docker image"
#docker tag "$ALPHA_IMAGE" "$HASHED_IMAGE"
echo "Pushing docker images"
#docker login --username="$DOCKER_USER" --email="$DOCKER_MAIL" --password="$DOCKER_PASSWORD"
docker push "$ALPHA_IMAGE"
#docker push "$HASHED_IMAGE"

echo "Done"
