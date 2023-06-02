#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

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
echo -e "${RED}     #################################################### ${NC}"
echo -e "${RED}     #                                                  # ${NC}"
echo -e "${RED}     #          WARNING EXPERIMENTAL SCRIPT FOR         # ${NC}"
echo -e "${RED}     #                PARALLEL OS UPDATE OF             # ${NC}"
echo -e "${RED}     #                MULTIPLE PLUGIN NODES             # ${NC}"
echo -e "${RED}     #                                                  # ${NC}"
echo -e "${RED}     # Created by s4njk4n - https://github.com/s4njk4n/ # ${NC}"
echo -e "${RED}     #                                                  # ${NC}"
echo -e "${RED}     #################################################### ${NC}"
echo
echo

# Set time (in seconds) to wait for your VPS to reboot. You'll have to manually test this. Recommend rounding UP by a minute or 2
echo
echo -e "${RED}How long (in seconds) should be allowed for VPS's to reboot?${NC}"
echo
echo -e "${RED}NOTE: If your VPS's take variable amounts of time to update and reboot${NC}"
echo -e "${RED}then the time you want to specify here is the total number of seconds to${NC}"
echo -e "${RED}wait for all updates and a reboot to complete on your SLOWEST VPS. You may${NC}"
echo -e "${RED}need to work it out by trial and error. Selecting a time too short is not${NC}"
echo -e "${RED}harmful. The final status checks may just not display a useful output.${NC}"
echo -e "${RED}If unsure, set it to something long like 600(seconds). Setting a longer${NC}"
echo -e "${RED}time isn't harmful, it will just take longer to finish the update.${NC}"
read WAITTOREBOOT
echo
echo

echo -e "${GREEN}Generating plain IP address list ${NC}"
rm $IPFILE > /dev/null 2>&1
cut -d "@" -f 2 $BASEFILE > $IPFILE
echo
echo

# Create a temporary script for remote execution
REMOTE_SCRIPT=$(mktemp)

# Define the commands to be executed remotely
cat <<EOF > $REMOTE_SCRIPT
#!/bin/bash

sudo -n apt-get update -y
sudo -n apt-get upgrade -y
sudo -n apt-get autoremove -y
sudo -n apt-get clean -y
sudo -n apt-get update -y
sudo -n apt-get upgrade -y
sudo -n apt-get autoremove -y
sudo -n apt-get clean -y
sudo -n reboot
EOF

# Set up pssh options
PSSH_OPTIONS="-h $IPFILE -l root -t 0"

echo
echo -e "${GREEN}Updating Plugin Nodes OS${NC}"
echo

# Execute the remote commands in parallel using pssh
parallel-ssh $PSSH_OPTIONS -i -I < $REMOTE_SCRIPT

echo
echo -e "${GREEN}Rebooting Plugin Nodes${NC}"
echo

# Wait for the specified time for the nodes to reboot
sleep $WAITTOREBOOT
echo
echo

echo -e "${GREEN}Retrieving Status of Plugin Nodes${NC}"
echo
echo

# Retrieve the status of Plugin Nodes using SSH connections
while IFS="@" read -r f1 f2
do
   echo -e "${GREEN}Retrieving Status of Plugin Node - $f2 ${NC}"
   echo
   ssh -n $f1@$f2 'pm2 status'
   echo
   echo

   echo -e "${GREEN}--------------------------------------------------------------- ${NC}"
   echo
done < $BASEFILE

rm $REMOTE_SCRIPT
rm $IPFILE

echo -e "${RED}ALL PLUGIN NODE OS UPDATES COMPLETED ${NC}"
echo
