#!/bin/bash

# TODO check available directories and privileges
# it works perfectly for macOS w/ homebrew but ubuntu server needs more privileges
echo "Downloading the executable"
curl -o git-clerk.sh https://raw.githubusercontent.com/ston1x/git-clerk/master/git-clerk.sh
echo "Copying to /usr/local/bin/git-clerk"
cp git-clerk.sh /usr/local/bin/git-clerk
echo "Making it executable"
chmod +x /usr/local/bin/git-clerk
