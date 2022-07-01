#!/bin/bash

# Set filename to obtain ip address list for Plugin Node VPS's to setup wth SSH-key authentication
FILE="ipaddresses"

# Set Colour Vars
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo
echo
echo -e "${GREEN}#################################################### ${NC}"
echo -e "${GREEN}#                                                  # ${NC}"
echo -e "${GREEN}#           SETUP SSH-KEY AUTHENTICATION           # ${NC}"
echo -e "${GREEN}#             FOR MULTIPLE PLUGIN NODES            # ${NC}"
echo -e "${GREEN}#                                                  # ${NC}"
echo -e "${GREEN}# Created by s4njk4n - https://github.com/s4njk4n/ #${NC}"
echo -e "${GREEN}#                                                  # ${NC}"
echo -e "${GREEN}#################################################### ${NC}"
echo
echo

echo -e "${RED}During this setup process you will be asked this many times: ${NC}"
echo -e "${RED}    - Are you sure you want to continue connecting ${NC}"
echo -e "${RED}Whenever you get this prompt, just type yes and press enter. ${NC}"
echo
echo -e "${RED}Whenever asked for the password for root@ip.address just enter ${NC}"
echo -e "${RED}the correct password for that VPS and press the enter key. ${NC}"
echo -e "${RED}Your SSH-key will then be copied for that user on the VPS. ${NC}"
echo

while IFS= read line
do

   echo
   echo -e "${GREEN}Setting up SSH-key based authentication for $line ${NC}"
   echo
   ssh-copy-id root@$line
   echo

done < "$FILE"

echo
echo -e "${RED}SSH-KEY AUTHENTICATION ESTABLISHED FOR ALL PLUGIN NODES ${NC}"
echo

