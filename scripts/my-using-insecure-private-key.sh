#!/usr/bin/env bash

if [ -f "/tmp/insecure_private_key" ] && [ ! -f "/home/vagrant/.ssh/insecure_private_key" ]; then
    mv /tmp/insecure_private_key /home/vagrant/.ssh/insecure_private_key
    chmod 400 /home/vagrant/.ssh/insecure_private_key
fi

