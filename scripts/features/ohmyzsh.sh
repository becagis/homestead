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
[[ -f /home/vagrant/.zsh-snap/znap.zsh ]] || git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git /home/vagrant/.zsh-snap
echo "source /home/vagrant/.zsh-snap/znap.zsh" | tee -a /home/vagrant/.zshrc
echo "znap source zsh-users/zsh-syntax-highlighting" | tee -a /home/vagrant/.zshrc
echo "znap source marlonrichert/zsh-autocomplete" | tee -a /home/vagrant/.zshrc
echo "znap source zsh-users/zsh-autosuggestions" | tee -a /home/vagrant/.zshrc


