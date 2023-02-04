#!/bin/bash
# CREDIT: https://github.com/NidukaAkalanka/x-ui-english
# CREDIT: https://github.com/vaxilu/x-ui/

################# EDIT TO YOURS!

# OLD SERVER DETAILS
OLD_IPv4=
OLD_LOGINNAME=root
OLD_PASSWORD=

# NEW SERVER DETAILS
NEW_IPv4=
NEW_LOGINNAME=root
NEW_PASSWORD=

DOMAIN_ADDRESS=
EMAIL_ADDRESS=
V2RAY_ADMINPANEL=NIDUKA
#NIDUKA #VAXILU

################# DONT CHANGE!
clear
function isRoot() {
        if [ "$EUID" -ne 0 ]; then
                return 1
        fi
}

if ! isRoot; then
        echo "Sorry, you need to run this as root"
        exit 1
fi
# COLOR SCRIPTING
YELLOW='\033[0;33m'	# YELLOW
RED='\033[0;31m'        # Red
BLUE='\033[1;34m'       # LIGHTBLUE
GREEN='\033[0;32m'      # Green
NC='\033[0m'            # No Color
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
bold(){
    echo -e "\033[1m\033[01m$1\033[0m"
}
Green_font_prefix="\033[32m" 
Red_font_prefix="\033[31m" 
Green_background_prefix="\033[42;37m" 
Red_background_prefix="\033[41;37m" 
Font_color_suffix="\033[0m"

clear
green "V2RAY X-UI PANEL SERVER CHANGER  V2.0"
green "----------------------------------------"
echo
green "Welcome to ExtremeDot X-UI panel migration Script"
echo

function oLDInfo() {
green "Please Enter OLD SERVER information here"
echo
read -e -i "$OLD_IPv4" -p "OLD SERVER: Please input PUBLIC IP v4: " input
OLD_IPv4="${input:-$OLD_IPv4}"
read -e -i "$OLD_LOGINNAME" -p "OLD SERVER: Please input Login Username: " input
OLD_LOGINNAME="${input:-$OLD_LOGINNAME}"
read -e -i "$OLD_PASSWORD" -p "OLD SERVER: Please input Login Password: " input
OLD_PASSWORD="${input:-$OLD_PASSWORD}"
oLDgETiNFO
}

# OLD SERVER GET DATA
function oLDgETiNFO() {
if [[ -z $OLD_IPv4 || -z $OLD_LOGINNAME || -z $OLD_PASSWORD ]]; then #INFORMATION IS NOT CORRECT
red "OLD SERVER: ERROR getting DATA"; echo
oLDInfo
else
echo
yellow "OLD SERVER INFORMATION ---------"
yellow "IP=[$OLD_IPv4]"
yellow "USER=[$OLD_LOGINNAME]  -   PASS=[$OLD_PASSWORD] "
OLD_SETUP=""
until [[ $OLD_SETUP =~ (y|n) ]]; do
read -rp "OLD SERVER: Confirm OLD Server Information? [y/n]: " -e -i y OLD_SETUP
done
if [[ $OLD_SETUP == "n" ]]; then
yellow "Setting New Values for OLD SERVER"
oLDInfo
fi; fi
}

### NEW SERVER DATA
function nEWInfo() {
echo "Please Enter NEW SERVER information here"
echo
read -e -i "$NEW_IPv4" -p "NEW SERVER: Please input PUBLIC IP v4: " input
NEW_IPv4="${input:-$NEW_IPv4}"
read -e -i "$NEW_LOGINNAME" -p "NEW SERVER: Please input Login Username: " input
NEW_LOGINNAME="${input:-$NEW_LOGINNAME}"
read -e -i "$NEW_PASSWORD" -p "NEW SERVER: Please input Login Password: " input
NEW_PASSWORD="${input:-$NEW_PASSWORD}"
nEWgETiNFO
}
# NEW SERVER GET DATA
function nEWgETiNFO() {
if [[ -z $NEW_IPv4 || -z $NEW_LOGINNAME || -z $NEW_PASSWORD ]]; then #INFORMATION IS NOT CORRECT
red "NEW SERVER: ERROR getting DATA"; echo
nEWInfo
else
echo
yellow "NEW SERVER INFORMATION ---------"
yellow "IP=[$NEW_IPv4]"
yellow "USER=[$NEW_LOGINNAME]  -   PASS=[$NEW_PASSWORD] "
NEW_SETUP=""
until [[ $NEW_SETUP =~ (y|n) ]]; do
read -rp "NEW SERVER: Confirm NEW Server Information? [y/n]: " -e -i y NEW_SETUP
done
if [[ $NEW_SETUP == "n" ]]; then
yellow "Setting New Values for NEW SERVER"
nEWInfo
fi; fi
}

### DOMAIN CHECK
#DOMAIN_ADDRESS=
#EMAIL_ADDRESS=
function dOMAINiNFO() {
clear
echo; green "New Server Domain Check"; echo
if [[ -z $DOMAIN_ADDRESS ]]; then #DOMAIN ADDRESS IS NOT ENTERED
red "NEW SERVER: ERROR getting DOMAIN name"; echo
read -e -i "$DOMAIN_ADDRESS" -p "NEW SERVER: Please enter damain address: " input
DOMAIN_ADDRESS="${input:-$DOMAIN_ADDRESS}"
fi




oLDgETiNFO
echo ; blue "------------------"; echo
nEWgETiNFO

