#!/bin/bash

# Set filename to obtain IP address list for Plugin Node VPS's to download backup files from
FILE="user_at_ip"

# Set unique directory name for this reservoir of node backup files
BACKUP_DIR="PLI_Node_Backup_Reservoir_"$(date +'%Y_%m_%d__%H_%M_%S')

# Set Colour Vars
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo
echo
echo -e "${GREEN}     #################################################### ${NC}"
echo -e "${GREEN}     #                                                  # ${NC}"
echo -e "${GREEN}     #              NODE BACKUP RETRIEVER               # ${NC}"
echo -e "${GREEN}     #            FOR MULTIPLE PLUGIN NODES             # ${NC}"
echo -e "${GREEN}     #                                                  # ${NC}"
echo -e "${GREEN}     # Created by s4njk4n - https://github.com/s4njk4n/ #${NC}"
echo -e "${GREEN}     #                                                  # ${NC}"
echo -e "${GREEN}     #################################################### ${NC}"
echo
echo

# Creating unique subdirectory (in user's home directory) as local reservoir of backups being copied
echo -e "${GREEN}Creating unique directory as local reservoir for Plugin node backups: ${NC}"
echo $HOME/$BACKUP_DIR
mkdir $HOME/$BACKUP_DIR
echo

# Retrieve Plugin node backup files for each node in user_at_IP file
while IFS= read line
do

   echo
   echo
   echo -e "${GREEN}Retrieving Backups from Plugin Node - $line ${NC}"
   mkdir $HOME/$BACKUP_DIR/$line
   scp $line:/plinode_backups/* $HOME/$BACKUP_DIR/$line
   echo

done < "$FILE"

echo
echo
echo -e "${RED}FINISHED RETRIEVING PLUGIN NODE BACKUP FILES ${NC}"
echo
echo -e "${GREEN}-------------------------------------------- ${NC}"
echo
echo -e "${GREEN}LOCAL RESERVOIR OF PLUGIN NODE BACKUPS CREATED AT:"
echo $HOME/$BACKUP_DIR/ 
echo -e "${NC}"
echo

