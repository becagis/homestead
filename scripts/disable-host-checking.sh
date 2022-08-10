#!/usr/bin/env bash

[ -f ~/.ssh/config ] || {
    cat > ~/.ssh/config <<EOF
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
EOF
}