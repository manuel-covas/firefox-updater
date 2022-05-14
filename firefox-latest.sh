#!/bin/bash

FIREFOX_DIR="/opt/firefox"
SYMLINK_PATH="/usr/local/bin/firefox"
DOWNLOAD_DIR="releases"
OS="linux64"
LANGUAGE="en-US"

# Create releases dir if not present

if [ ! -d "$DOWNLOAD_DIR" ]; then
  mkdir releases
  echo "Created $DOWNLOAD_DIR directory."
fi

cd releases
wget --trust-server-names "https://download.mozilla.org/?product=firefox-latest&os=$OS&lang=$LANGUAGE"

ARCHIVE=$(ls -1t | head -n 1)

echo "Replacing $FIREFOX_DIR with contents from $ARCHIVE"
echo "Press enter to start..."
read

echo "Extracting..."
tar xjf $ARCHIVE

echo "Moving (sudo) firefox to $FIREFOX_DIR..."
sudo rm $FIREFOX_DIR -rf
sudo mv firefox $FIREFOX_DIR

echo "Creating symlink $SYMLINK_PATH -> $FIREFOX_DIR/firefox/firefox"
sudo ln -s $FIREFOX_DIR/firefox $SYMLINK_PATH

echo "Downloading .desktop file"
wget --trust-server-names "https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop"
mv firefox.desktop ..
