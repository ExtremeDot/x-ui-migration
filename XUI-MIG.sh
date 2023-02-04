#!/bin/bash
# CREDIT: https://github.com/NidukaAkalanka/x-ui-english
# CREDIT: https://github.com/vaxilu/x-ui/
# CREDIT: https://github.com/proxykingdev/x-ui

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
V2RAY_ADMINPANEL=NIDUKA #NIDUKA is DEFAULT
#NIDUKA #VAXILU #PROXYKING
FIREWALLINS=YES
FIREWALLSTART=300
FIREWALLSTOP=350
#YES #NO
PANELPORT=12345


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

if [ $(dpkg-query -W -f='${Status}' sshpass 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
yellow " Installing sshpass"
apt install -y sshpass
else
green "sshpass has installed"
fi
if [ $(dpkg-query -W -f='${Status}' dnsutils  2>/dev/null | grep -c "ok installed") -eq 0 ];
then
yellow "Installing dnsutils"
apt install -y dnsutils 
else
green "dnsutils has installed"
fi


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
read -rp "NEW SERVER: Confirm E-MAIL Address? [y/n]: " -e -i y EMAILANMES
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
if [[ $OVERALLCHECK == "y" ]]; then
sTARTmIGRATION
else
exit; fi
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

function xANkERNELiNSTALL() {
echo ; green "Installing XanMod Kernel"
apt install curl
echo ; green "Downloading the XanMod repository files..."
curl -fSsL https://dl.xanmod.org/gpg.key | gpg --dearmor | tee /usr/share/keyrings/xanmod.gpg > /dev/null && sleep 1
echo 'deb [signed-by=/usr/share/keyrings/xanmod.gpg] http://deb.xanmod.org releases main' | tee /etc/apt/sources.list.d/xanmod-kernel.list && sleep 1
grep xanmod /etc/apt/sources.list.d/xanmod-kernel.list && sleep 1
echo ; green "Updating System... starting."
apt -y update
apt -y upgrade
echo "" ; echo "Updating System... finished."
echo ""
echo "What XanMod Kernel Version want to install? ?"
echo "   1) Stable XanMod Kernel Release"
echo "   2) Latest Kernel XanMod EDGE (recommended for the latest kernel)"
echo "   3) XanMod LTS (Kernel 5.15 LTS) "
echo " "
until [[ $KERNINSTAL =~ ^[0-3]+$ ]] && [ "$KERNINSTAL" -ge 1 ] && [ "$KERNINSTAL" -le 3 ]; do
read -rp "KERNINSTAL [1-3]: " -e -i 2 KERNINSTAL
done
case $KERNINSTAL in
1) # Stable XanMod Kernel Release
echo "" $$ echo "Stable XanMod Kernel Install.."
apt install linux-xanmod
;;
2) # Latest Kernel XanMod EDGE
echo "" $$ echo "Latest Kernel XanMod EDGE Install.."
apt install linux-xanmod-edge
;;
3) # XanMod LTS
echo "" $$ echo "XanMod LTS Install.."
apt install linux-xanmod-lts
echo -e "${GREEN}"
;;
esac
echo ; green "Kernel has installed ..."
echo ; green"updating system ..."
apt install -y intel-microcode iucode-tool
sleep 2
}


function sTARTmIGRATION() {
clear
echo ; green "Start Moving X-UI Panel to New Server"

# IF its in old Server
if [[ $VPSMACHINE == "OLD" ]]; then
yellow "OLD SERVER is Detected!"; echo
red " PLEASE RUN SCRIPT OVER NEW SERVER"
red " E X I T "
echo
sleep 5 && exit 0
#green "Uploading X-UI files into NEW Server"
#sshpass -p "$NEW_PASSWORD" scp -o StrictHostKeyChecking=no /usr/local/x-ui/bin/config.json $NEW_LOGINNAME@$NEW_IPv4:/usr/local/x-ui/bin/config.json
#sleep 1
#sshpass -p "$NEW_PASSWORD" scp -o StrictHostKeyChecking=no /etc/x-ui/x-ui.db $NEW_LOGINNAME@$NEW_IPv4:/etc/x-ui/x-ui.db
#sleep 1
else if [[ $VPSMACHINE == "NEW" ]]; then
yellow "New SERVER is Detected!"; echo
green "Installing V2Ray Panel, [$V2RAY_ADMINPANEL]"; echo
green "update and upgrading system.."
apt update && apt upgrade -y

until [[ $XANKERNELIN1 =~ (y|n) ]]; do
read -rp "Install XANMOD Kernel? BBR2 Enabled [y/n]: " -e -i n XANKERNELIN1
done
if [[ $XANKERNELIN1 == "y" ]]; then
echo ; green "Installing XANMOD KERNEL"
xANkERNELiNSTALL
else
echo ; green "XAN KERNEL SKIPPED"
fi

echo; green "Installing ACME certificate tool"
apt install curl socat -y
sleep 1
curl https://get.acme.sh | sh
sleep 1
~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
sleep 1
~/.acme.sh/acme.sh --register-account -m $EMAIL_ADDRESS
sleep 1
~/.acme.sh/acme.sh --issue -d $DOMAIN_ADDRESS --standalone
sleep 1
clear
~/.acme.sh/acme.sh --installcert -d $DOMAIN_ADDRESS --key-file /root/private.key --fullchain-file /root/cert.crt
echo ; green "Certfiles are installed and copied to :"; echo
blue "/root/cert.crt"
blue "/root/private.key"
echo

green "Enabling BBR?"
yellow "Skip if you have installed XANMOD KERNEL"
until [[ $BBREANBLE =~ (y|n) ]]; do
read -rp "Enable BBR? ? [y/n]: " -e -i n BBREANBLE
done
if [[ $BBREANBLE == "y" ]]; then
echo "Enabling BBR "
yellow "Enable BBR acceleration"
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sleep 1
sysctl -p
else
sleep 1
echo "Skipping BBR Enabling"
fi

# Enable IPV6 ?
echo
green "Do you want to enable IPv6? Avoid Google reCAPTCHA human verification"
until [[ $IPV6ABLE =~ (y|n) ]]; do
read -rp "Enable IPV6 Support? ? [y/n]: " -e -i y IPV6ABLE
done
if [[ $IPV6ABLE == "y" ]]; then
echo "Enabling IPV6 Support"
if [[ $(sysctl -a | grep 'disable_ipv6.*=.*1') || $(cat /etc/sysctl.{conf,d/*} | grep 'disable_ipv6.*=.*1') ]]; then
        sed -i '/disable_ipv6/d' /etc/sysctl.{conf,d/*}
        echo 'net.ipv6.conf.all.disable_ipv6 = 0' >/etc/sysctl.d/ipv6.conf
        sysctl -w net.ipv6.conf.all.disable_ipv6=0
fi
sleep 1
fi

#### INSTALLING X-UI PANEL
if [[ $V2RAY_ADMINPANEL == "VAXILU" ]]; then
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
else if [[ $V2RAY_ADMINPANEL == "PROXYKING" ]]; then
mkdir -p /tmp/v2Server && cd /tmp/v2Server
wget --no-check-certificate -O install https://raw.githubusercontent.com/proxykingdev/x-ui/master/install
sleep 1 && chmod +x install
/tmp/v2Server/./install
else
bash <(curl -Ls https://raw.githubusercontent.com/NidukaAkalanka/x-ui-english/master/install.sh)
fi; fi

#### FIREWALL INSTALLATION
if [[ $FIREWALLINS == "YES" ]]; then
if [ $(dpkg-query -W -f='${Status}' ufw 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
green " Installing Firewall"
apt install -y ufw;
clear
green " Firewall is installed " ;
else
green " Firewall has installed allready.." ;
fi
yellow " Please enter the Port number for ADMIN v2ray Panel"
echo
read -e -i "$PANELPORT" -p "please Enter X-UI Panel Port: " input
PANELPORT="${input:-$PANELPORT}"
echo
yellow " Please enter the STARTING Port number for Users over v2ray Panel"
echo
read -e -i "$FIREWALLSTART" -p "Please Enter STARTING Port for users: " input
FIREWALLSTART="${input:-$FIREWALLSTART}"
echo 
yellow " Please enter the ENDING Port number for Users over v2ray Panel"
read -e -i "$FIREWALLSTOP" -p "Please Enter ENDING Port for users: " input
FIREWALLSTOP="${input:-$FIREWALLSTOP}"
echo
green "Open ports for ssh, http and https access."
ufw allow http
ufw allow https
ufw allow ssh
echo
green "Firewall Opened Port for X-UI admin panel on $PANELPORT port."
echo
ufw allow $PANELPORT
sleep 1
green "Firewall Opened Ports from $FIREWALLSTART to $FIREWALLSTOP for Users access."
ufw allow $FIREWALLSTART:$FIREWALLSTOP/tcp
sleep 1
ufw allow $FIREWALLSTART:$FIREWALLSTOP/udp
sleep
green "Enabling Firewall"
ufw enable
echo
green " you can disable or enable firewall using commands:"
blue " ufw enable"
red " ufw disable"
fi

######## MOVING FILES INTO NEW SERVER
green "Downloading X-UI files from OLD Server"
sshpass -p "$NEW_PASSWORD" scp -o StrictHostKeyChecking=no $NEW_LOGINNAME@$NEW_IPv4:/usr/local/x-ui/bin/config.json /usr/local/x-ui/bin/config.json
sleep 1
sshpass -p "$NEW_PASSWORD" scp -o StrictHostKeyChecking=no $NEW_LOGINNAME@$NEW_IPv4:/etc/x-ui/x-ui.db /etc/x-ui/x-ui.db
sleep 1
else
red "Can't reconize current VPS Detection, New or Old?"
green "Copy /usr/local/x-ui/bin/config.json and /etc/x-ui/x-ui.db into new server"
echo
fi; fi

green "REBOOT YOUR SYSTEM AND CHECK NEW V2RAY PANEL"
echo
green "$DOMAIN_ADDRESS:$PANELPORT or NEW_IPv4:$PANELPORT"
yellow "Certificates are located in /root/cert.crt and /root/private.key"
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
