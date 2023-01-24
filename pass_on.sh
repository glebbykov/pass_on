#!/bin/bash

# Script to enable password authentication and set user password

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

sudo sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "Please enter the password for the current user:"
read -s user_password

echo $user_password | sudo passwd --stdin $(whoami)

# Determine the system type
if [ -f /etc/lsb-release ]; then
    # Debian/Ubuntu Linux user run
    sudo systemctl reload ssh.service
elif [ -f /etc/redhat-release ]; then
    # RHEL/CentOS Linux user run
    sudo systemctl reload sshd.service
else
    echo "Unable to determine system type"
    exit 1
fi

if sudo grep -q "^PasswordAuthentication yes" /etc/ssh/sshd_config; then
    echo "Password authentication is now enabled"
else
    echo "Error enabling password authentication"
fi
