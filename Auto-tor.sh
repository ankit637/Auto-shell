#!/bin/bash

#echo "Starting Tor Browser..."
#cd /home/kali/Downloads/tor-browser
#./start-tor-browser.desktop


echo "Starting Tor Browser..."

sudo apt-get install tor

torfile=/etc/tor/torrc

# Define the file path
file=$torfile

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "File $file does not exist."
    exit 1
fi

# Use sed to edit lines 71 and 72
sed -i '71s/^#//' "$file"
sed -i '72s/^#//' "$file"

echo "Lines 71 and 72 modified in $file"

# Check if apache2 service is running
if service apache2 status >/dev/null 2>&1; then
    echo "Apache2 is already running."
else
    echo "Starting Apache2 service..."
    service apache2 start
fi

# Check if tor service is running
if service tor status >/dev/null 2>&1; then
    echo "Tor is already running."
else
    echo "Starting Tor service..."
    service tor start
fi

# Attempt to install xclip
if ! command -v xclip &>/dev/null; then
    echo "Installing xclip..."
    sudo apt-get update
    sudo apt-get install -y xclip

    # Check if installation was successful
    if [ $? -ne 0 ]; then
        echo "Failed to install xclip. Exiting."
        exit 1
    fi
fi


cd /home/kali/Downloads/tor-browser
./start-tor-browser.desktop

# Copy the .onion address from the hostname file to clipboard
sudo cat /var/lib/tor/hidden_service/hostname | xclip -selection clipboard

echo "Hostname copied to clipboard. You can now paste it in the Tor Browser."
