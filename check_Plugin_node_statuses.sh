#!/bin/bash

# Set filename to obtain IP address list for Plugin Node VPS's to setup wth SSH-key authentication
FILE="useratip"

# Set Colour Vars
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo
echo
echo -e "${GREEN}     #################################################### ${NC}"
echo -e "${GREEN}     #                                                  # ${NC}"
echo -e "${GREEN}     #               NODE STATUS CHECKER                # ${NC}"
echo -e "${GREEN}     #            FOR MULTIPLE PLUGIN NODES             # ${NC}"
echo -e "${GREEN}     #                                                  # ${NC}"
echo -e "${GREEN}     # Created by s4njk4n - https://github.com/s4njk4n/ #${NC}"
echo -e "${GREEN}     #                                                  # ${NC}"
echo -e "${GREEN}     #################################################### ${NC}"
echo
echo

while IFS= read line
do

   echo
   echo
   echo -e "${GREEN}Retrieving Status of Plugin Node - $line ${NC}"
   echo
   ssh -n $line 'pm2 status'

done < "$FILE"

echo
echo
echo -e "${RED}PLUGIN NODE STATUS RETRIEVAL COMPLETE ${NC}"
echo

