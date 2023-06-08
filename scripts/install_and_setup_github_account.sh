#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

existing_wget=`which git || echo ""`
if [ -z "existing_git" ]; then
    echo ""
    echo "Will be installed git, please use your root password"
    su -c "apt -y install git >> /dev/null"
fi

echo -n "Please enter the path (ending with /) of the SSH keys that are used to authenticate your GitHub sesion: "
read sshKeys

rsync -a $sshKeys ~/.ssh

echo -n "Please enter the path and file name of the GPG private key that is used to sign your GitHub commits: "
read gpgPrivateKey

gpg --import gpgPrivateKey

echo -n "Please enter the path and file name of the GPG public key that is used to sign your GitHub commits: "
read gpgPublicKey

gpg --import gpgPublicKey

echo -n "Please enter the path (ending with /) of the .gitconfig and .gitmessage files: "
read gitSetupFiles

rsync -a $gitSetupFiles ~


