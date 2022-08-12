#!/usr/bin/env bash

if [ -f ~/.homestead-features/wsl_user_name ]; then
    WSL_USER_NAME="$(cat ~/.homestead-features/wsl_user_name)"
    WSL_USER_GROUP="$(cat ~/.homestead-features/wsl_user_group)"
else
    WSL_USER_NAME=vagrant
    WSL_USER_GROUP=vagrant
fi

export DEBIAN_FRONTEND=noninteractive

if [ -f /home/$WSL_USER_NAME/.homestead-features/node ]
then
    echo "node already installed."
    exit 0
fi

touch /home/$WSL_USER_NAME/.homestead-features/node
chown -Rf $WSL_USER_NAME:$WSL_USER_GROUP /home/$WSL_USER_NAME/.homestead-features

# Determine wanted version from config
set -- "$1"
IFS=".";

if [ -z "${version}" ]; then
    installVersion="--lts" # by not specifying we'll install latest
else
    installVersion="${version}"
fi

which nvm -v > /dev/null || su - vagrant -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash'

su - vagrant -c "source /home/vagrant/.nvm/nvm.sh && nvm install ${installVersion} && npm install -g pnpm"