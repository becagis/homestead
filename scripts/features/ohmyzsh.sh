#!/usr/bin/env bash

if [ -f ~/.homestead-features/wsl_user_name ]; then
    WSL_USER_NAME="$(cat ~/.homestead-features/wsl_user_name)"
    WSL_USER_GROUP="$(cat ~/.homestead-features/wsl_user_group)"
else
    WSL_USER_NAME=vagrant
    WSL_USER_GROUP=vagrant
fi

export DEBIAN_FRONTEND=noninteractive

if [ -f /home/$WSL_USER_NAME/.homestead-features/oh-my-zsh ]
then
    echo "oh-my-zsh already installed."
    exit 0
fi

touch /home/$WSL_USER_NAME/.homestead-features/oh-my-zsh
chown -Rf $WSL_USER_NAME:$WSL_USER_GROUP /home/$WSL_USER_NAME/.homestead-features

# Install oh-my-zsh
rm -rf /home/vagrant/.oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/vagrant/.oh-my-zsh
cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc
printf "\nemulate sh -c 'source ~/.bash_aliases'\n" | tee -a /home/vagrant/.zprofile
printf "\nemulate sh -c 'source ~/.profile'\n" | tee -a /home/vagrant/.zprofile
chown -R vagrant:vagrant /home/vagrant/.oh-my-zsh
chown vagrant:vagrant /home/vagrant/.zshrc
chown vagrant:vagrant /home/vagrant/.zprofile
chsh -s /bin/zsh vagrant

# Install plugins
# https://jpcercal.com/en/iterm2-plus-zplug-means-productivity/
# https://www.woefe.com/posts/bootstrap_zsh.html
su - vagrant -c 'curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh'

tee -a /home/vagrant/.zshrc <<EOF

###########################################################
# Pre configuration

# Define the environment variable ZPLUG_HOME 
export ZPLUG_HOME=/home/vagrant/.zplug

# Loads zplug
source \$ZPLUG_HOME/init.zsh

# Clear packages
zplug clear

###########################################################
# Packages

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "marlonrichert/zsh-autocomplete"
zplug "zsh-users/zsh-history-substring-search"

###########################################################
# Theme

# zplug 'dracula/zsh', as:theme

###########################################################
# Install packages that have not been installed yet

# zplug check returns true if all packages are installed
! zplug check --verbose && zplug install

# source plugins and add commands to the PATH
zplug load
EOF
