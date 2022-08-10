Use Git Bash
```shell
bash init.sh
curl https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant > ~/.ssh/insecure_private_key && chmod 400 ~/.ssh/insecure_private_key
curl https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub > ~/.ssh/insecure_private_key.pub && chmod 400 ~/.ssh/insecure_private_key.pub
```

```shell
vagrant provision --provision-with "Run after.sh"
vagrant provision --provision-with "Installing node"
vagrant provision --provision-with "Installing ohmyzsh"
vagrant provision --provision-with "Installing rvm"
vagrant provision --provision-with "enable password authentication"
vagrant provision --provision-with "using insecure private key"
```