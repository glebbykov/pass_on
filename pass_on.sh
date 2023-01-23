#!/bin/bash

# Script to enable password authentication and set user password

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

sudo sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "Please enter the password for the current user:"
read -s user_password

echo $user_password | sudo passwd --stdin $(whoami)

sudo systemctl reload ssh

if grep -q "^PasswordAuthentication yes" /etc/ssh/sshd_config; then
    echo "Password authentication is now enabled"
else
    echo "Error enabling password authentication"
fi
