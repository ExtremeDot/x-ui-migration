#!/bin/bash
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

echo "V2RAY X-UI PANEL SERVER CHANGER  V1.1"
echo "----------------------------------------"
PS3=" $(echo $'\n'-----------------------------$'\n' "   Enter Option: " ) "
echo ""
options=( "Clean BACKUP Folder" "OLD SERVER : BACKUP X-UI" "02-A:NEW SERVER - Installing Certificate [ACME]" "02-B:NEW SERVER - Installing Certificate [CERTBOT]" "03- Installing X-UI English Panel [proxykingdev]" "04-NEW SERVER: RESTORE XUI" "List Certbot" "ReNew Certbot" "CLEAR" "Quit")
select opt in "${options[@]}"
do
case $opt in

"Clean BACKUP Folder")
clear
echo ""
echo "Do you sure the DELETE BACKUPS? "
echo ""
until [[ $CLEAN_BACKUP =~ (y|n) ]]; do
read -rp "Delete Backups? [y/n]: " -e -i y CLEAN_BACKUP
done

if [[ $CLEAN_BACKUP == "y" ]]; then
echo "Cleaning Backup Folder"
rm -rf /dot_migrate_xui
else
echo "Canceled"
fi
;;

# OLD SERVER
"OLD SERVER : BACKUP X-UI")
clear
mkdir -p /dot_migrate_xui
sleep 1
cp /usr/local/x-ui/bin/config.json /dot_migrate_xui/config.json
cp /etc/x-ui/x-ui.db /dot_migrate_xui/x-ui.db
echo " Download WinSCP programs"
echo " Connect to this server and download 2 files from /dot_migrate_xui folder "
echo ""
echo "/dot_migrate_xui/x-ui.db"
echo "/dot_migrate_xui/config.json"
echo ""
;;

# ACME SETUP SERVER
"02-A:NEW SERVER - Installing Certificate [ACME]")
clear
echo ""
echo "Do you sure the acme certifcate was set to your old server?"
echo "ACME Setup?"
echo ""
until [[ $ACME_SETUP =~ (y|n) ]]; do
read -rp "Install Certificate using ACME? [y/n]: " -e -i y ACME_SETUP
done

if [[ $ACME_SETUP == "y" ]]; then
echo "Installing SOCAT and CURL"
apt install curl socat -y
sleep 1
echo ""
EMAILADD=""
read -e -i "$EMAILADD" -p "Enter Email Address: for ex: admin@gmail.com " input
EMAILADD="${input:-$EMAILADD}"
echo ""
echo "IMPORTANT: Set NEW SERVER IP to your DOMAIN"
echo "Doamin name you are entering, must return current server IP"
echo ""
DOMAINNM=""
read -e -i "$DOMAINNM" -p "Enter Domain name: for ex: dot.router.com " input
DOMAINNM="${input:-$DOMAINNM}"
echo ""
curl https://get.acme.sh | sh
sleep 1
~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
sleep 1
~/.acme.sh/acme.sh --register-account -m $EMAILADD
sleep 1
~/.acme.sh/acme.sh --issue -d $DOMAINNM --standalone
sleep 1
~/.acme.sh/acme.sh --installcert -d $DOMAINNM --key-file /root/private.key --fullchain-file /root/cert.crt
sleep 1
echo ""
echo "Your certifcates are loacted in"
echo ""
echo "/root/cert.crt"
echo "/root/private.key"

else echo "ACME SETUP : CANCELED" ;
fi
;;

# CERTBOT SETUP SERVER
"02-B:NEW SERVER - Installing Certificate [CERTBOT]")
clear
echo ""
echo "Do you sure the certbot certifcate was set to your old server?"
echo "CERTBOT Setup?"
echo ""
echo "IMPORTANT: Set NEW SERVER IP to your DOMAIN"
echo "Doamin name you are entering, must return current server IP"
echo "Please be ensure the right DNS settings on cloudflre dashboard for this domain"
echo ""
until [[ $CERTBOT_SETUP =~ (y|n) ]]; do
read -rp "Install Certificate using CERTBOT? [y/n]: " -e -i y CERTBOT_SETUP
done

if [[ $CERTBOT_SETUP == "y" ]]; then
if [ $(dpkg-query -W -f='${Status}' snapd 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
echo " Installing SNAP"
apt install -y snap snapd;
else echo " It was installed" ;
fi
snap install core
snap refresh core
sleep 1
snap install --classic certbot
sleep 1
sudo ln -s /snap/bin/certbot /usr/bin/certbot
echo ""
sudo certbot certonly --standalone
else
echo "CERTBOT: CANCELED"
fi
;;

"03- Installing X-UI English Panel [proxykingdev]")
clear
echo""
echo "Installing proxykingdev X-UI Panel"
echo " GITUHB: https://github.com/proxykingdev/x-ui "
echo ""
mkdir -p /tmp/v2Server
cd /tmp/v2Server
wget --no-check-certificate -O install https://raw.githubusercontent.com/proxykingdev/x-ui/master/install
sleep 1
chmod +x install
/tmp/v2Server/./install
;;

"04-NEW SERVER: RESTORE XUI")
clear
echo""
mkdir -p /dot_migrate_xui
sleep 1
echo " Download WinSCP programs"
echo " Connect to this server and UPLOAD 2 files into /dot_migrate_xui folder "
echo " Waiting for you, when done"
echo ""
until [[ $RESTORE_SERNEW =~ (y|n) ]]; do
read -rp "Uploaded files into /dot_migrate_xui folder? [y/n]: " -e -i y RESTORE_SERNEW
done
if [[ $RESTORE_SERNEW == "y" ]]; then
echo ""
echo " Restoring Backups ......"
cp /dot_migrate_xui/config.json /usr/local/x-ui/bin/config.json
cp /dot_migrate_xui/x-ui.db /etc/x-ui/x-ui.db
echo ""
echo " Now reboot your server to make changes"
else echo " Canceled"
fi

;;

"List Certbot")
certbot certificates
;;

"ReNew Certbot")
certbot renew --force-renewal
;;


# Quit
"Quit")
	break
;;

# CLEAR SCREEN
"CLEAR")
	clear
;;


# WRONG INPUT
*) echo "invalid option $REPLY"
;;
esac

# DONE
done
