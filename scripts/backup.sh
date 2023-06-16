#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

existing_rsync=`which rsync || echo ""`
if [ -z "existing_rsync" ]; then
    echo ""
    echo "Will be installed rsync, please use your root password"
    su -c "apt -y install rsync >> /dev/null"
fi

export GPGKEYS=~/.gnupg
export SSHKEYS=~/.ssh
export GITCONFIG=~/.gitconfig
export DOCUMENTS=~/Documents
export PICTURES=~/Pictures
export ATUIN_HISTORY=~/.local/share/atuin
export DEST=/media/$(whoami)/support/backup

rsync -au $GPGKEYS $SSHKEYS $DOCUMENTS $PICTURES $GITCONFIG $ATUIN_HISTORY $DEST

