#!/bin/bash
#
# Pretend "build" script fro spinnaker-jib demo project...
# 
# Expects release version as argument (defaults to "Unknown")

version=0.1.1
release=$1
fullversion="${version}-${release:-unknown}"
buildDir=build
htmlDir=$buildDir/html
rootDir=$(pwd)
echo "Building spinnaker-jib project..."
sleep 5

echo "Cleaning $buildDir directory..."
sleep 2
[ -d $buildDir ] && rm -rf $buildDir

echo "Creating new $htmlDir directory and generating build..."
sleep 2
mkdir -p $htmlDir
cp -r src/* $htmlDir/$

echo "Updating version to ${fullversion}..."
# Is it safe to just run this on all files in the $buildDir?
sed -i s/VERSION/${fullversion}/ $htmlDir/index.html
sed -i s/VERSION/${fullversion}/ $htmlDir/health

echo "Packaging..."
sleep 2
./package.sh $fullversion

BUCKET=spinnaker-demo-apt-repo
PACKAGE_PATH=build
deb-s3 upload --bucket $BUCKET --arch amd64 --codename trusty --preserve-versions true $PACKAGE_PATH/*.deb
