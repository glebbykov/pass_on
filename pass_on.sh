#!/bin/bash

# Script to enable password authentication and set user password

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

sudo sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "Please enter the password for the current user:"

read -s user_password

echo $user_password | sudo passwd --stdin $(whoami)

# Identify the Linux platform
platform=$(cat /etc/*-release | grep -E '^ID=' | cut -d '=' -f 2 | tr -d '"')

case "$platform" in
    centos)
      sudo systemctl reload sshd.service
      ;;

    debian)
      sudo systemctl reload ssh.service
      ;;

    fedora)
      sudo systemctl reload sshd.service
      ;;

    ubuntu)
      sudo systemctl reload ssh.service
      ;;
    *)
      # Error message
      echo "Error: Unable to determine system type"
      exit 1
      ;;
  esac

if [ $? -ne 0 ]; then
    echo "Error reloading the ssh service. Exiting."
    exit 1
fi

if sudo grep -q "^PasswordAuthentication yes" /etc/ssh/sshd_config; then
    echo "Password authentication is now enabled"
else
    echo "Error enabling password authentication"
    exit 1
fi
