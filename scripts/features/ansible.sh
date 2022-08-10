#!/usr/bin/env bash

if [ -f ~/.homestead-features/wsl_user_name ]; then
    WSL_USER_NAME="$(cat ~/.homestead-features/wsl_user_name)"
    WSL_USER_GROUP="$(cat ~/.homestead-features/wsl_user_group)"
else
    WSL_USER_NAME=vagrant
    WSL_USER_GROUP=vagrant
fi

export DEBIAN_FRONTEND=noninteractive

if [ -f /home/$WSL_USER_NAME/.homestead-features/ansible ]
then
    echo "ansible already installed."
    exit 0
fi

touch /home/$WSL_USER_NAME/.homestead-features/ansible
chown -Rf $WSL_USER_NAME:$WSL_USER_GROUP /home/$WSL_USER_NAME/.homestead-features

apt-get update -yqq && \
    apt-get install -yqq software-properties-common

apt-add-repository -y ppa:ansible/ansible && apt-get update -yqq

# Install ansible
apt-get install -y ansible

# Setting up Ansible bash completion support
apt-get install -y python3-argcomplete && activate-global-python-argcomplete3