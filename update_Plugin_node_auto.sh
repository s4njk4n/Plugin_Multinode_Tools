#!/bin/bash

# Set filename to obtain IP address list for StorX Node VPS's to Update
FILE="ipaddresses"

# Set Colour Vars
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo
echo
echo -e "${GREEN}#################################################### ${NC}"
echo -e "${GREEN}#                                                  # ${NC}"
echo -e "${GREEN}#                AUTOMATIC UPDATER                 # ${NC}"
echo -e "${GREEN}#            FOR MULTIPLE PLUGIN NODES             # ${NC}"
echo -e "${GREEN}#                                                  # ${NC}"
echo -e "${GREEN}# Created by s4njk4n - https://github.com/s4njk4n/ #${NC}"
echo -e "${GREEN}#                                                  # ${NC}"
echo -e "${GREEN}#################################################### ${NC}"
echo
echo

while IFS= read line
do

   echo
   echo -e "${GREEN}Updating Plugin Node OS - $line ${NC}"
   echo
   ssh -n root@$line 'sudo apt update -y'
   ssh -n root@$line 'sudo apt upgrade -y'
   ssh -n root@$line 'sudo apt autoremove -y'
   ssh -n root@$line 'sudo apt clean -y'
   ssh -n root@$line 'sudo apt update -y'
   ssh -n root@$line 'sudo apt upgrade -y'
   ssh -n root@$line 'sudo apt autoremove -y'
   ssh -n root@$line 'sudo apt clean -y'

   echo
   echo -e "${GREEN}Rebooting VPS - $line ${NC}"
   ssh -n root@$line 'reboot' > /dev/null 2>&1


   echo
   echo -e "${GREEN}--------------------------------------------------------------- ${NC}"
   echo

done < "$FILE"

echo -e "${RED}ALL PLUGIN NODE UPDATES COMPLETED ${NC}"
echo

