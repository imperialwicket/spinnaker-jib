#!/bin/bash
#
# Pretend "build" script fro spinnaker-jib demo project...
# 
# Expects release version as argument (defaults to "Unknown")

release=$1
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
sed -i s/VERSION/${release:-Unknown}/ $buildDir/index.html

cd $buildDir
tar czf $release.tar.gz *
cd $rootDir

echo "Pushing this release to s3..."
sleep 2
aws s3 cp $buildDir/$release.tar.gz s3://someBucket/spinnaker-jib/

# There is no try, only do.
exit 0
