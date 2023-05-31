#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

apt update > /dev/null

scripts_dir=$(pwd)
dotfiles_dir=$scripts_dir/..

existing_wget=`which wget || echo ""`
if [ -z "existing_wget" ]; then
    echo ""
    echo "Will be installed wget, please user the root password"
    su -c "apt -y install wget >> /dev/null"
fi

cat <<END
+-------------------------------------------------------+
  The installation and configuration process of ZSH
  will be start. In order to set ZSH as the default
  shell you should to use your user password.
+-------------------------------------------------------+
END

cp dotfiles_dir/.zshrc ~/

apt install -y zsh

chsh -s $(which zsh)

zsh
