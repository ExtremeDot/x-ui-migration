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
clear
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
clear
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
function gETdOMAINiNFO() {
clear
echo; red "NEW SERVER: ERROR getting DOMAIN name"; echo
read -e -i "$DOMAIN_ADDRESS" -p "NEW SERVER: Please enter damain address: " input
DOMAIN_ADDRESS="${input:-$DOMAIN_ADDRESS}"
cHECKdOMAINiNFO
}

function cHECKdOMAINiNFO() {
green "New Server Domain Check"; echo
if [[ -z $DOMAIN_ADDRESS ]]; then #DOMAIN ADDRESS IS NOT ENTERED
gETdOMAINiNFO
else
echo ; yellow "DomainName= [$DOMAIN_ADDRESS]";
DOMAINANMES=""
until [[ $DOMAINANMES =~ (y|n) ]]; do
read -rp "NEW SERVER: Confirm Domain Name? [y/n]: " -e -i y DOMAINANMES
done
if [[ $DOMAINANMES == "n" ]]; then
yellow "Specify Domain Name"
gETdOMAINiNFO
fi; fi
}

######## EMAIL CHECK
#EMAIL_ADDRESS=
function gETeMAILiNFO() {
clear
echo; red "NEW SERVER: ERROR getting E-MAIL Address"; echo
read -e -i "$EMAIL_ADDRESS" -p "NEW SERVER: Please enter E-MAIL address: " input
EMAIL_ADDRESS="${input:-$EMAIL_ADDRESS}"
cHECKeMAILiNFO
}

function cHECKeMAILiNFO() {
green "New Server Email Address Check"; echo
if [[ -z $EMAIL_ADDRESS ]]; then #E-MAIL ADDRESS IS NOT ENTERED
gETeMAILiNFO
else
echo ; yellow "E-MAIL Address= [$EMAIL_ADDRESS]";
EMAILANMES=""
until [[ $EMAILANMES =~ (y|n) ]]; do
read -rp "NEW SERVER: Confirm Domain Name? [y/n]: " -e -i y EMAILANMES
done
if [[ $EMAILANMES == "n" ]]; then
yellow "Specify E-MAIL ADDRESS"
gETeMAILiNFO
fi; fi
}

function cHECKdOMAINiP() {
echo
green "$DOMAIN_ADDRESS IP must be $NEW_IPv4, now check the ip of domain!"
IPCHECKNEWDOMAIN=`dig +short $DOMAIN_ADDRESS` && sleep 1
DOMCHECKS=""
until [[ $DOMCHECKS =~ (y|n) ]]; do
read -rp "[$IPCHECKNEWDOMAIN] is set to [$DOMAIN_ADDRESS], is Correct? [y/n]: " -e -i y DOMCHECKS
done
if [[ $DOMCHECKS == "n" ]]; then
red "Setup proccess is paused now"
yellow "goto Cloudflare dashboard and set [$NEW_IPv4] IP for [$DOMAIN_ADDRESS]"
yellow "don't forget to Set to \"DNS ONLY\" "
echo
green "when you change the domain to new ip , press Enter to continue"
DOMCHECKS2=""
until [[ $DOMCHECKS2 =~ (y|n) ]]; do
read -rp "Have you updated Domain Settings to New Server's IP? [y/n]: " -e -i y DOMCHECKS2
done
if [[ $DOMCHECKS2 == "n" ]]; then
cHECKdOMAINiP
fi; fi
}

function cHECKoVERALLiNFO() {
clear
green "V2RAY X-UI PANEL SERVER CHANGER  V2.0"; echo
yellow "This Server is detected as= [#VPSMACHINE] "
green "V2RAY PANEL: DOMAIN=[$DOMAIN_ADDRESS] - E-MAIL=[$EMAIL_ADDRESS]"
green "OLD SERVER: IP=[$OLD_IPv4] - USER=[$OLD_LOGINNAME] - PASS=[$OLD_PASSWORD]"
yellow "NEW SERVER: IP=[$NEW_IPv4] - USER=[$NEW_LOGINNAME] - PASS=[$NEW_PASSWORD]"
green "NEW PANEL [$DOMAIN_ADDRESS] is set to [$IPCHECKNEWDOMAIN]"
echo
OVERALLCHECK=""
until [[ $OVERALLCHECK =~ (y|n) ]]; do
read -rp "Everything is ok and Start moving OLD Server to New? [y/n]: " -e -i y OVERALLCHECK
done
sTARTmIGRATION
}

function iPvPSdETECTION() {
CURRENTPUBIP=`curl --silent -4 icanhazip.com`
#$NEW_IPv4 #$OLD_IPv4
if [[ $CURRENTPUBIP == $NEW_IPv4 ]]; then
echo "Its NEW Server VPS"
VPSMACHINE=NEW
else if [[ $CURRENTPUBIP == $OLD_IPv4 ]]; then
echo "Its OLD Server VPS"
VPSMACHINE=OLD
else
echo "ERROR, Can't reconize "
VPSMACHINE=UNKNOWN
fi; fi 
}

function sTARTmIGRATION() {
clear
echo ; green "Start Moving X-UI Panel to New Server"

}

echo ; blue "-OLD SERVER==================="; echo
oLDgETiNFO
echo ; blue "-NEW SERVER==================="; echo
nEWgETiNFO
echo ; blue "-DOMAIN CHECK================="; echo
cHECKdOMAINiNFO
echo ; blue "-EMAIL CHECK=================="; echo
cHECKeMAILiNFO
echo ; blue "-DOMAIN NEW IP CHECK=========="; echo
cHECKdOMAINiP
echo ; blue "-VPS CHECK===================="; echo
iPvPSdETECTION
echo ; blue "-OVERALL CHECK================"; echo
cHECKoVERALLiNFO
