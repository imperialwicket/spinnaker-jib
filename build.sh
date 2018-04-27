#!/bin/bash
#
# Pretend "build" script fro spinnaker-jib demo project...
# 
# Expects release version as argument (defaults to "Unknown")

version=0.1.1
release=$1
fullversion="${version}-${release:-unknown}"
buildDir=build
rootDir=$(pwd)
echo "Building spinnaker-jib project..."
sleep 5

echo "Cleaning $buildDir directory..."
sleep 2
[ -d $buildDir ] && rm -rf $buildDir

echo "Creating new $buildDir directory and generating build..."
sleep 2
mkdir $buildDir
cp src/* $buildDir
sed -i s/VERSION/${fullversion}/ $buildDir/index.html


echo "Packaging..."
sleep 2
./package.sh $fullversion

BUCKET=spinnaker-demo-apt-repo
PACKAGE_PATH=build
deb-s3 upload --bucket $BUCKET --arch amd64 --codename trusty --preserve-versions true $PACKAGE_PATH/*.deb
