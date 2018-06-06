#!/bin/bash

if [ ! $version ]; then
  echo "An environment variable 'version' is not set"
  exit 2
fi

VERSION="$version" # fix for a build environment

TMP_DIR=azimuth3imager_$VERSION-1_all

USR_DIR=/usr/local/bin

APP_DIR=/usr/share/applications

ICONS_DIR=/usr/share/icons/hicolor/scalable/apps

echo "Building C++ scripts"

./compile.sh

echo "Creating temporary directory and copying files"

mkdir -p "$TMP_DIR$USR_DIR"

mkdir -p "$TMP_DIR$APP_DIR"

mkdir -p "$TMP_DIR$ICONS_DIR"

cp -rp build/* "$TMP_DIR$USR_DIR"

cp -rp azimuth3imager "$TMP_DIR$USR_DIR"

cp -rp assets/azimuth3imager.desktop "$TMP_DIR$APP_DIR"

cp -rp assets/tbdd-a3i.svg "$TMP_DIR$ICONS_DIR"

cp -rp DEBIAN $TMP_DIR

echo "Adding version to DEBIAN/control"
echo "Version: $VERSION" >> $TMP_DIR/DEBIAN/control

echo "Creating package"

fakeroot dpkg-deb --no-uniform-compression --build $TMP_DIR

echo "Removing $TMP_DIR"

rm -rf $TMP_DIR
