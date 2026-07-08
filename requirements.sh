#!/bin/bash

# Requirements:
# lolcat
# figlet
# nmap
# netdiscover
# above
# dirbuster
# whois
# ddos-ripper
# python3
# phonextract
# sparrow-wifi
# wireshark
# medusaphisher
# zphisher
# responder
# cowsay

# Shortcut Command


# Sudo apt install
sudo apt install lolcat -y
sudo apt install figlet -y
sudo apt install nmap -y
sudo apt install netdiscover -y
sudo apt install above -y
sudo apt install dirbuster -y
sudo apt install whois -y
sudo apt install python3 -y
sudo apt install sparrow-wifi -y
sudo apt install wireshark -y
sudo apt install responder -y
sudo apt install cowsay -y

# Git clone
git clone https://github.com/palahsu/DDoS-Ripper.git
git clone https://github.com/thakur2309/phonextract.git
git clone https://github.com/Adrilaw/MedusaPhisher.git
git clone https://github.com/htr-tech/zphisher.git

# Information, Directory Fix, and Shortcut
clear
echo "[*] Checking installation status..."

# 1. Find the directory where this script is currently running
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"

# 2. Define the destination
DEST_DIR="/usr/local/bin/HAKEM"
LAUNCHER="/usr/local/bin/hakem"

# 3. Check if already installed
if [ -d "$DEST_DIR" ] && [ -f "$LAUNCHER" ]; then
    echo "[!] HAKEM appears to be already installed in $DEST_DIR"
    read -p "Do you want to overwrite? (y/n): " OVERWRITE
    if [ "$OVERWRITE" != "y" ]; then
        echo "[*] Installation cancelled."
        exit 0
    fi
    echo "[*] Removing old installation..."
    sudo rm -rf "$DEST_DIR" "$LAUNCHER"
fi

# 4. Move the entire directory to /usr/local/bin
echo "[*] Moving HAKEM directory to $DEST_DIR..."
# We move the parent folder of the script to ensure all files (zphisher, configs) go with it
# Assuming this script is inside the HAKEM folder. 
# If this script IS the main folder content, we move the whole folder it resides in.
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
FOLDER_NAME="$(basename "$SCRIPT_DIR")"

# If the script is inside a folder named HAKEM, we move that folder.
# If the script is just a file in a folder with other files, we move the whole folder.
if [ "$FOLDER_NAME" == "HAKEM" ]; then
    sudo mv "$SCRIPT_DIR" /usr/local/bin/
else
    # Fallback: Move the folder containing the script
    sudo mv "$SCRIPT_DIR" "$DEST_DIR"
fi

# 5. Create a global launcher (so you can just type 'hakem')
echo "[*] Creating global launcher command..."
sudo bash -c "cat > $LAUNCHER << 'EOF'
#!/bin/bash
exec /usr/local/bin/HAKEM/HAKEM \"\$@\"
EOF"
# Note: Ensure the internal script name is 'HAKEM'. Adjust if your main script has a different name.

# 6. Set Permissions
sudo chmod +x "$DEST_DIR/HAKEM"
sudo chmod +x "$LAUNCHER"

# 7. Verify
if command -v hakem &> /dev/null; then
    echo ""
    echo -e "${GREENL}============================================${NC}"
    echo -e "${GREENL} Installation Successful! ${NC}"
    echo -e "${GREENL}============================================${NC}"
    echo "[*] You can now type 'hakem' from anywhere."
    echo "[*] Try running: hakem -h"
    echo ""
else
    echo "[!] Installation might have failed. Please check permissions."
fi
 
