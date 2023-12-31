#!/bin/bash

echo "
      WELCOME TO AUTO-SHELL by ANKIT SHUKLA(GPT)

      THIS TOOL CAN PERFORM:-
      NMAP, DIRB, SUBLISTER, SUBFINDER, WP-SCAN

"
read -p "Enter Your Project Folder Name:-" folder

read -p "Enter The IP For Nmap:-" ip

read -p "Enter The Port For Scaning:-" port

read -p "Enter The Domain:-" domain

read -p "Enter The URL For WP-Scan:-" url

mkdir $folder && cd $folder

mkdir Nmap

mkdir Directory-URL

mkdir Subdomains

mkdir Wordpress

mkdir Downloaded-wordlists

# URL of the wordlist on GitHub with a permalink to raw content

wordlist_url="https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/CMS/wordpress.fuzz.txt"

# Destination file path where you want to save the wordlist including the filename

destination_path="/home/kali/Desktop/ams/shell-script/ide/project/Downloaded-wordlists/wordpress.fuzz.txt"

# Download the wordlist using curl
curl -o "$destination_path" -L "$wordlist_url"

#--------------------------------------------------------------------------------------------------------------------
# URL of the wordlist on GitHub with a permalink to raw content

wordlist_url="https://raw.githubusercontent.com/drtychai/wordlists/master/dirbuster/directory-list-2.3-medium.txt"

# Destination file path where you want to save the wordlist including the filename

destination_path="/home/kali/Desktop/ams/shell-script/ide/project/Downloaded-wordlists/directory-list-2.3-medium.txt"

# Download the wordlist using curl
curl -o "$destination_path" -L "$wordlist_url"

#--------------------------------------------------------------------------------------------------------------------
# network scan

nmap $ip -p $port -sV -v -sS -Pn -oX Nmap/nmap_output.xml

#--------------------------------------------------------------------------------------------------------------------
# wordpress

wpscan --$url --enumerate --verbose -o Wordpress/enumerate_output.txt

dirb $url Downloaded-wordlists/wordpress.fuzz.txt -v -o Wordpress/wpdir_output.txt

#--------------------------------------------------------------------------------------------------------------------

# Directory

apt-get install gobuster

sudo apt-get install dirsearch

gobuster dir -u $url -w Downloaded-wordlists/directory-list-2.3-medium.txt -v -o Directory-URL/gobuster_results.txt

cp Wordpress/wpdir_output.txt Directory-URL

dirb $url -v -o Directory-URL/dirb_output.txt

dirsearch -u https://www.wscubetech.com -o dirsearch_output.txt

#--------------------------------------------------------------------------------------------------------------------

# subdomain
apt-get install amass

sudo apt-get install assetfinder

assetfinder $domain > Subdomains/assetfinder_output.txt

amass enum -d $domain -o Subdomains/amass_output.txt

subfinder -d $domain -v -o Subdomains/subfinder_output.txt

sublist3r -d $domain -v -b -o Subdomains/sublist3r_output.txt

#--------------------------------------------------------------------------------------------------------------------







