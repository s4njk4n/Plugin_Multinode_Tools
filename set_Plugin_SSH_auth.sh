#!/bin/bash

# Set filename to obtain ip address list for Plugin Node VPS's to setup wth SSH-key authentication
BASEFILE="user_at_ip"

# The plain ipaddresses file will be autogenerated from our BASEFILE further down
IPFILE="ip_addresses"

# Set Colour Vars
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo
echo
echo -e "${GREEN}     #################################################### ${NC}"
echo -e "${GREEN}     #                                                  # ${NC}"
echo -e "${GREEN}     #        SETUP SSH KEY-BASED AUTHENTICATION        # ${NC}"
echo -e "${GREEN}     #             FOR MULTIPLE PLUGIN NODES            # ${NC}"
echo -e "${GREEN}     #                                                  # ${NC}"
echo -e "${GREEN}     # Created by s4njk4n - https://github.com/s4njk4n/ #${NC}"
echo -e "${GREEN}     #                                                  # ${NC}"
echo -e "${GREEN}     #################################################### ${NC}"
echo
echo

echo -e "${RED}For each VPS you will be asked to enter the passwords for: ${NC}"
echo -e "${RED} - the ROOT user for that VPS; and then ${NC}"
echo -e "${RED} - also for the VPS username that the Plugin node was installed under ${NC}"
echo
echo -e "${RED}Your SSH-key will then be copied for both those users on the VPS. ${NC}"
echo
echo -e "${GREEN}Press any key to commence... ${NC}"
read -p " "

echo
echo -e "${GREEN}Generating plain IP address list for root users ${NC}"
rm $IPFILE > /dev/null 2>&1
cut -d "@" -f 2 $BASEFILE > $IPFILE
echo
echo

paste -d "@" $IPFILE $BASEFILE | while IFS="@" read -r f1 f2
do

   echo
   echo -e "${GREEN}Setting up SSH key-based authentication for $f1 ${NC}"
   echo
   ssh-copy-id -o "StrictHostKeyChecking=no" root@$f1
   echo
   ssh-copy-id -o "StrictHostKeyChecking=no" $f2
   echo

done

rm $IPFILE

echo
echo -e "${RED}SSH KEY-BASED AUTHENTICATION ESTABLISHED FOR ALL PLUGIN NODES ${NC}"
echo

