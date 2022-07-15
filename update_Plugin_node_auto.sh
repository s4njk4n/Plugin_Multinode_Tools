#!/bin/bash

# Set filename to obtain IP address list for Plugin Node VPS's to Update
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
echo -e "${GREEN}     #                AUTOMATIC UPDATER                 # ${NC}"
echo -e "${GREEN}     #            FOR MULTIPLE PLUGIN NODES             # ${NC}"
echo -e "${GREEN}     #                                                  # ${NC}"
echo -e "${GREEN}     # Created by s4njk4n - https://github.com/s4njk4n/ #${NC}"
echo -e "${GREEN}     #                                                  # ${NC}"
echo -e "${GREEN}     #################################################### ${NC}"
echo
echo

# Set time (in seconds) to wait for your VPS to reboot. You'll have to manually test this. Recommend rounding UP by a minute or 2
echo
echo -e "${RED}How long (in seconds) should be allowed for each VPS to reboot? (Must be LONGER ${NC}"
echo -e "${RED}than the boot time of your SLOWEST booting node). If unsure, set it to ${NC}"
echo -e "${RED}something long like 300(seconds). Setting a longer time isn't harmful, it will ${NC}"
echo -e "${RED}just take longer to finish all the nodes.${NC}"
read WAITTOREBOOT
echo
echo

echo -e "${GREEN}Generating plain IP address list ${NC}"
rm $IPFILE > /dev/null 2>&1
cut -d "@" -f 2 $BASEFILE > $IPFILE
echo
echo

paste -d "@" $IPFILE $BASEFILE | while IFS="@" read -r f1 f2
do

   echo
   echo -e "${GREEN}Updating Plugin Node OS - $f2 ${NC}"
   echo

   # Quirks of certain VPS providers require us to run the commands below twice   
   ssh -n root@$f1 'sudo apt update -y'
   ssh -n root@$f1 'sudo apt upgrade -y'
   ssh -n root@$f1 'sudo apt autoremove -y'
   ssh -n root@$f1 'sudo apt clean -y'
   ssh -n root@$f1 'sudo apt update -y'
   ssh -n root@$f1 'sudo apt upgrade -y'
   ssh -n root@$f1 'sudo apt autoremove -y'
   ssh -n root@$f1 'sudo apt clean -y'
   echo

   echo -e "${GREEN}Rebooting VPS - $f2 ${NC}"
   
   ssh -n root@$f1 'reboot' > /dev/null 2>&1
   sleep $WAITTOREBOOT
   echo
   echo

   echo -e "${GREEN}Retrieving Status of Plugin Node - $f2 ${NC}"
   echo
   echo
   
   ssh -n $f2 'pm2 status'
   echo
   echo

   echo -e "${GREEN}--------------------------------------------------------------- ${NC}"
   echo

done

rm $IPFILE

echo -e "${RED}ALL PLUGIN NODE OS UPDATES COMPLETED ${NC}"
echo

