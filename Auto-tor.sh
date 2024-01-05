#!/bin/bash

#echo "Welcome To Deep-Host"

#read -p "Enter the tor-bowser path:-" torpath

#service apache2 start

#tor

#cd $torpath

#./start-tor-browser.desktop

#cat /var/lib/tor/hidden_service/hostname




echo "Welcome To Deep-Host"

read -p "Enter the Tor Browser path: " torpath

# Start the Apache service (optional)
sudo service apache2 start

# Start Tor
tor &

# Wait for Tor to start (optional, give it some time)
sleep 5

# Change to the Tor Browser directory
cd "$torpath"

exit

cd "$torpath"

# Open the Tor Browser
./start-tor-browser.desktop &

# Wait for the Tor Browser to start (optional)
sleep 20  # Adjust the time as needed based on your system

# Copy the .onion address from the hostname file to clipboard
cat /var/lib/tor/hidden_service/hostname | xclip -selection clipboard

echo "Hostname copied to clipboard. You can now paste it in the Tor Browser."
