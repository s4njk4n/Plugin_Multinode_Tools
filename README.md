# Plugin_Multinode_Tools
## Tools for managing multiple Plugin nodes


As per Plugin, it is important to ensure that a node's VPS OS is up to date. 

Keeping all nodes up to date takes time, especially if you have multiple nodes and are dealing with them all one-by-one. These scripts are designed
to automate and streamline the process so we can manage larger groups of nodes in an easier and more time-efficient manner.

These tools have been created for the use of myself and a few others. If you plan to use them, please take some time to read through the scripts and
understand them.

Also, please do not be afraid of any jargon. The process of using the scripts will be shown below clearly (hopefully).

---

### WHAT THE SCRIPTS DO


_set_Plugin_SSH_auth.sh_

This script streamlines the process of setting up SSH key-based authentication. VPS usernames and IP addresses are read from the "user_at_ip" text
file that you will setup below. Managing multiple nodes is MUCH easier when using SSH keys to access each VPS. We need SSH key-based authentication
set up in order to use the actual "updating" scripts we're going to use.


_update_Plugin_node_auto.sh_

This script sequentially updates EVERY node listed in the "user_at_ip" text file that you will setup below. SSH key-based authentication needs to be
already setup in order for this script to be useful.


_check_Plugin_node_statuses.sh_

This script will sequentially check and display the status of EVERY node listed in the "user_at_ip" text file that you will setup below. SSH key-based
authentication needs to be already setup in order for this script to be useful. Once finished running, you can scroll up and down in your terminal
window to see the current status that each node is showing.

---

### ITEMS TO NOTE

* These scripts do not run directly on any of your node VPS's. You will need an additional computer (running Ubuntu 20.04) that these scripts will be
  installed on (eg. laptop, desktop, virtual machine, VPS). If you are using the StorX Multinode Tools as well, then these scripts can all be installed
  on the same computer
* The computer you setup for these updates should be one YOU control and only YOU have access to. Using SSH key-based authentication means that this
  administration computer can connect to your nodes whenever it needs to without needing you to manually enter the password for the node VPS. This is
  by design and is how the scripts manage to run multiple commands to update each node whilst remaining unattended. As you can see, this computer must
  not be a random public computer. It must be your computer that you control with your own passwords.

---

### INITIAL SETUP

1. Logon to (or access the terminal on) the computer you will be using for administering your Plugin nodes. You will need to be at the command prompt
   in the terminal in order to perform the following steps.

2. Update the system and install base packages:

```
    sudo apt update -y && sudo apt upgrade -y && sudo apt install -y git ssh && sudo apt autoremove -y
```

3. Clone the scripts repository:

```
    cd $HOME
    sudo rm -r Plugin_Multinode_Tools
    git clone https://github.com/s4njk4n/Plugin_Multinode_Tools.git
    cd Plugin_Multinode_Tools
    chmod +x *.sh
```
4. Make sure to press ENTER after pasting the above code into the terminal


#### CUSTOMISE THE "user_at_ip" FILE

1. Open the "user_at_ip" file in nano:

```
    nano ~/Plugin_Multinode_Tools/user_at_ip
```

2. When adding VPS details to this file, EACH VPS will have its details on a separate line. On EACH LINE you will need to enter 3 things relevant to
   the VPS in question (with no spaces between the items). These are:
   a) The new username that was created to install your Plugin node on the VPS;
   b) The @ symbol;
   c) The IP address of the VPS that this line of the file is referring to.
   For example: username@123.456.789.110
   There should be NO SPACES at the start or end of each line. Press ENTER at the end of each line after you finishing entering the last digit of the
   IP address. The exception to this is that when you have entered the FINAL IP address you will not press ENTER to create a new line.

3. Once the details of all the node VPS's have been entered, we need to exit nano and save the file:

```
    Press "CTRL+X" 
    Press "y"
    Press "ENTER"
```


#### SETUP SSH KEY-BASED AUTHENTICATION

(Note: You must have setup the "user_at_ip" file in the above section first)


##### GENERATE SSH KEYS 

If you have already generated SSH keys earlier (if you're also using and have already installed the StorX Multinode Tools for example), please skip this key-generation step and proceed directly to the next section below with the heading "Register SSH Keys On Nodes"

1. Create your SSH keys that will be used for authentication:

```
    ssh-keygen
```

2. You will then be asked several questions to generate the key. Just keep pressing ENTER to accept the default responses. When finished, you'll
   arrive back at your normal command prompt.


##### REGISTER SSH KEYS ON NODES

1. Run the set_Plugin_SSH_auth.sh script:

```
    cd ~/Plugin_Multinode_Tools && ./set_Plugin_SSH_auth.sh
```

2. For each node you will receive a request to enter (for the node indicated by the ip address shown in the prompt) first the root password and then
   the password for the new username you created when you initially installed your Plugin node . Put in each password for that node and press ENTER
   after each one.

3. By doing the above steps the script will sequentially access each node and copy your SSH credentials to it.

---

### TO UPDATE ALL YOUR NODES

1. First you need to know how long it takes for your SLOWEST node to reboot. For example, if most of your nodes at one provider can reboot in
   10sec, but you have some nodes at another provider that take 3min to reboot, then you need to know this rough figure as you will be asked
   for it when you run the update script.

2. Run the update script:

```
    cd ~/Plugin_Multinode_Tools && ./update_Plugin_node_auto.sh
```

3. You will be prompted to enter how long the script should wait to allow for your nodes to reboot. If you enter a time that is too short then the
   node status that is loaded after rebooting will not be displayed correctly. If you enter a time that is longer than the time it takes your node
   VPS to reboot, this is no major problem as it will just mean that the update process will just take a little longer. The time you enter should
   just be the number of seconds to wait. For example, to wait 60sec, one would just type 60 and press ENTER. Be aware that some commercial VPS
   providers have reboot times that are VERY SLOOOOOOW. If you're not sure how long it takes for yours or if you want to be on the safe side then
   just pick something long like 300 seconds (ie. type 300 and press ENTER)

4. Now sit back and wait. Feel free to watch the script work or go away and do something else until it is finished. Alternately if you have some
   ridiculous number of nodes then go away and leave your computer on until the updates are completed.

---

### TO CHECK THE STATUS OF ALL YOUR NODES

1. This script will query and show the status of every node VPS listed in the "user_at_ip" file you setup earlier above. If not done yet, you will
   need to setup the "user_at_ip" file as per the instructions above first.

2. Run the script to check your nodes:

```
    cd ~/Plugin_Multinode_Tools && ./check_Plugin_node_statuses.sh
```

3. Watch while the status of each node is shown sequentially in your terminal window, or alternately go away and come back later when it is finished.
   You will be able to scroll back up the terminal window later to review them all if there are too many to watch while they are checked one-by-one.

---
