#!/bin/bash

# Pretend test harness...
fail=0

echo "Doing some testing for spinnaker-jib..."
sleep 5

title="Spinnaker Demonstration"
echo "Testing for \"$title\" text in title..."
sleep 2
titleTest=$(cat src/index.html | grep "$title")
if [ $? -gt 0 ]; then
      	fail=1
	echo "FAIL"
else
	echo "PASS"
fi

versionText="VERSION"
echo "Testing for \"$versionText\" placeholder text in index..."
sleep 2
versionTest=$(cat src/index.html | grep "$verstionText")
if [ $? -gt 0 ]; then
	fail=1
	echo "FAIL"
else
	echo "PASS"
fi

exit $fail
