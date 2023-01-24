# SSH Password Authentication Script

A simple bash script to enable password authentication and set user password on Linux systems.

## Usage

1. Download the script and make it executable:

curl https://raw.githubusercontent.com/username/repository/master/ssh-password-auth.sh -o ssh-password-auth.sh
chmod +x ssh-password-auth.sh

2. Run the script:
sudo ./ssh-password-auth.sh

3. Enter the desired password for the current user when prompted.

4. The script will then backup the current ssh configuration file, enable password authentication in it, and reload the ssh service based on the system type.

5. The script will check the ssh configuration file to ensure that password authentication is now enabled and display a message indicating the success or failure.

## Note

This script automatically identifies the Linux platform, whether it is centos, debian, fedora or ubuntu and reloads the appropriate ssh service. It also includes error handling and input validation by adding checks for the success or failure of each command and action, as well as added a check to ensure that the password entered is not empty. It also includes exit codes, so the script will exit if any error occurs, avoiding unexpected results. The script also added messages to indicate the reason for exiting in case of an error, which will help with troubleshooting and debugging.

