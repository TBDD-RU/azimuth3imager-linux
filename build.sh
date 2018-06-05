#!/bin/bash

VERSION="$version" # fix for build environment

TMP_DIR=azimuth3imager_$VERSION-1_all

USR_DIR=/usr/local/bin

echo "Building C++ scripts"

./compile.sh

echo "Creating temporary directory and copying files"

mkdir -p "$TMP_DIR$USR_DIR"

cp -rp build/* "$TMP_DIR$USR_DIR"

cp -rp azimuth3imager "$TMP_DIR$USR_DIR"

cp -rp DEBIAN $TMP_DIR

echo "Adding version to DEBIAN/control"
echo "Version: $VERSION" >> $TMP_DIR/DEBIAN/control

echo "Creating package"

fakeroot dpkg-deb --no-uniform-compression --build $TMP_DIR

echo "Removing $TMP_DIR"

rm -rf $TMP_DIR
