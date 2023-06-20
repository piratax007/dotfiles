#!/usr/bin/env bash

set -e

# export DEBIAN_FRONTEND=noninteractive

existing_rsync=`which rsync || echo ""`
if [ -z "existing_rsync" ]; then
    echo ""
    echo "Will be installed rsync, please use your root password"
    su -c "apt -y install rsync >> /dev/null"
fi

export SSHKEYS=~/.ssh
export GITCONFIG=~/.gitconfig
export DOCUMENTS=~/Documents
export PICTURES=~/Pictures
export ATUIN_HISTORY=~/.local/share/atuin
export DEST=/media/$(whoami)/support/backup
export GPGKEYS=/media/$(whoami)/support/backup/gpgkeys

rsync -au $SSHKEYS $DOCUMENTS $PICTURES $GITCONFIG $ATUIN_HISTORY $DEST

# Github gpg CAD keys
gpg --pinentry-mode loopback --export-secret-keys --armor 07D0D1142E8CC84D > $GPGKEYS/gpg_private_github_cad.asc
gpg --pinentry-mode loopback --export --armor 07D0D1142E8CC84D > $GPGKEYS/gpg_public_github_cad.asc



