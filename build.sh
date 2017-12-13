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
aws s3 cp $buildDir/$release.tar.gz s3://spinnaker-demo-releases/
s3Ret=$?
[ $s3Ret -gt 0 ] && echo "Error uploading $release.tar.gz" && exit $s3Ret

echo "Successfully uploaded $release.tar.gz"
# us-east-1 buckets are all kinds of eventual... so...
echo "Waiting for s3 object to be available..."
sleep 30

exit 0

